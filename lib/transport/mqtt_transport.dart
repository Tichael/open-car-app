import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:open_car_app/config/mqtt_broker_config.g.dart';
import 'package:open_car_app/generated/opencar/core/v1/core.pb.dart';
import 'package:typed_data/typed_data.dart' as typed;

import 'car_transport.dart';

class MqttCarTransport implements CarTransport {
  final _controller = StreamController<DeviceToApp>.broadcast();
  StreamSubscription<List<MqttReceivedMessage<MqttMessage>>>?
  _updatesSubscription;
  Timer? _reconnectTimer;
  int _reconnectAttempt = 0;
  bool _disposed = false;

  late final MqttServerClient _client;
  late final String _cmdTopic;
  late final String _dataTopic;

  MqttCarTransport({
    required String commandTopicTemplate,
    required String dataTopicTemplate,
    required String connectionClientId,
  }) {
    _cmdTopic = commandTopicTemplate.replaceAll('{client_id}', kMqttClientId);
    _dataTopic = dataTopicTemplate.replaceAll('{client_id}', kMqttClientId);

    _client = MqttServerClient(kMqttBrokerHost, connectionClientId)
      ..port = kMqttBrokerPort
      ..keepAlivePeriod = 30
      ..autoReconnect = true
      ..logging(on: kDebugMode)
      ..onDisconnected = _onDisconnected
      ..onConnected = _onConnected
      ..onAutoReconnected = _onAutoReconnected
      ..onSubscribed = _onSubscribed
      ..onSubscribeFail = _onSubscribeFail;

    _client.connectionMessage = MqttConnectMessage()
        .withClientIdentifier(connectionClientId)
        .startClean();

    unawaited(_connect());
    dev.log(
      'Connecting to $kMqttBrokerHost:$kMqttBrokerPort',
      name: 'MqttTransport',
    );
  }

  Future<void> _connect() async {
    if (_disposed) return;

    final state = _client.connectionStatus?.state;
    if (state == MqttConnectionState.connected ||
        state == MqttConnectionState.connecting) {
      return;
    }

    try {
      await _client.connect(kMqttUsername, kMqttPassword);
      if (_client.connectionStatus?.state != MqttConnectionState.connected) {
        _scheduleReconnect('connect completed but not connected');
      }
    } on MqttNoConnectionException catch (e) {
      _scheduleReconnect('no connection: $e');
    } on Exception catch (e) {
      _scheduleReconnect('connect exception: $e');
    }
  }

  void _scheduleReconnect(String reason) {
    if (_disposed) return;
    if (_reconnectTimer?.isActive ?? false) return;

    final delaySeconds = math.min(30, 1 << _reconnectAttempt);
    _reconnectAttempt = math.min(_reconnectAttempt + 1, 5);
    dev.log(
      'Scheduling reconnect in ${delaySeconds}s ($reason)',
      name: 'MqttTransport',
    );

    _reconnectTimer = Timer(Duration(seconds: delaySeconds), () {
      _reconnectTimer = null;
      unawaited(_connect());
    });
  }

  void _onConnected() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _reconnectAttempt = 0;
    dev.log('Connected; subscribing to $_dataTopic', name: 'MqttTransport');
    _client.subscribe(_dataTopic, MqttQos.atLeastOnce);
    // Cancel any existing subscription before adding a new one — _onConnected
    // fires on every CONNACK (initial connection and each auto-reconnect), so
    // without this guard we would accumulate duplicate listeners.
    _updatesSubscription?.cancel();
    _updatesSubscription = _client.updates.listen(_onMessage);
  }

  void _onAutoReconnected() {
    dev.log('Auto-reconnected', name: 'MqttTransport');
    // mqtt5_client re-subscribes automatically when resubscribeOnAutoReconnect
    // is true (the default).  No manual action needed here.
  }

  void _onSubscribed(MqttSubscription subscription) {
    dev.log(
      'Subscription confirmed: ${subscription.topic.rawTopic}',
      name: 'MqttTransport',
    );
  }

  void _onSubscribeFail(MqttSubscription subscription) {
    dev.log(
      'Subscription REJECTED by broker: ${subscription.topic.rawTopic}',
      name: 'MqttTransport',
    );
  }

  void _onDisconnected() {
    if (_disposed) return;
    final origin = _client.connectionStatus?.disconnectionOrigin;
    final reason = _client.connectionStatus?.reasonCode;
    dev.log(
      'Disconnected — origin: $origin, reasonCode: $reason',
      name: 'MqttTransport',
    );
    // Safety net: explicit retry loop for cases where autoReconnect does not
    // recover (e.g. initial startup while broker is down).
    _scheduleReconnect('disconnected');
  }

  void _onMessage(List<MqttReceivedMessage<MqttMessage>> messages) {
    for (final m in messages) {
      if (kDebugMode) {
        dev.log(
          'Message received on topic: "${m.topic}" (expected: "$_dataTopic")',
          name: 'MqttTransport',
        );
      }
      if (m.topic != _dataTopic) continue;
      final publish = m.payload as MqttPublishMessage;
      final bytes = publish.payload.message;
      if (bytes == null || bytes.isEmpty) continue;
      try {
        final msg = DeviceToApp.fromBuffer(bytes);
        if (kDebugMode)
          dev.log(
            'Decoded DeviceToApp (${bytes.length} bytes)',
            name: 'MqttTransport',
          );
        if (!_controller.isClosed) _controller.add(msg);
      } on Exception catch (e) {
        dev.log('Malformed protobuf discarded: $e', name: 'MqttTransport');
      }
    }
  }

  @override
  TransportType get transportType => TransportType.mqtt;

  @override
  Stream<DeviceToApp> get messages => _controller.stream;

  @override
  Future<void> send(AppToDevice message) async {
    if (_client.connectionStatus?.state != MqttConnectionState.connected) {
      dev.log('Send skipped: not connected', name: 'MqttTransport');
      return;
    }
    if (!message.hasBasicCommandBytes()) {
      dev.log(
        'Send skipped: advanced command not supported over MQTT',
        name: 'MqttTransport',
      );
      return;
    }

    final buffer = typed.Uint8Buffer()..addAll(message.writeToBuffer());
    _client.publishMessage(_cmdTopic, MqttQos.atLeastOnce, buffer);
  }

  @override
  void dispose() {
    _disposed = true;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _updatesSubscription?.cancel();
    _client.disconnect();
    _controller.close();
  }
}
