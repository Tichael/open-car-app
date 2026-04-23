import 'dart:async';

import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:open_car_app/config/mqtt_broker_config.g.dart';
import 'package:open_car_app/generated/opencar/core/v1/core.pb.dart';
import 'package:typed_data/typed_data.dart' as typed;

import 'car_transport.dart';

class MqttCarTransport implements CarTransport {
  final _controller = StreamController<DeviceToApp>.broadcast();

  late final MqttServerClient _client;
  late final String _cmdTopic;
  late final String _dataTopic;

  MqttCarTransport({
    required String commandTopicTemplate,
    required String dataTopicTemplate,
  }) {
    _cmdTopic = commandTopicTemplate.replaceAll('{client_id}', kMqttClientId);
    _dataTopic = dataTopicTemplate.replaceAll('{client_id}', kMqttClientId);

    _client = MqttServerClient(kMqttBrokerHost, kMqttClientId)
      ..port = kMqttBrokerPort
      ..keepAlivePeriod = 30
      ..autoReconnect = true
      ..logging(on: false)
      ..onDisconnected = _onDisconnected
      ..onConnected = _onConnected
      ..onAutoReconnected = _onAutoReconnected;

    _client.connectionMessage = MqttConnectMessage()
        .withClientIdentifier(kMqttClientId)
        .startClean();

    unawaited(_connect());
  }

  Future<void> _connect() async {
    try {
      await _client.connect(kMqttUsername, kMqttPassword);
    } on MqttNoConnectionException {
      // autoReconnect will retry; nothing to do here.
    } on Exception {
      // Swallow all other connection-time exceptions; autoReconnect handles them.
    }
  }

  void _onConnected() {
    _client.subscribe(_dataTopic, MqttQos.atLeastOnce);
    _client.updates.listen(_onMessage);
  }

  void _onAutoReconnected() {
    // Re-subscribe after automatic reconnect.
    _client.subscribe(_dataTopic, MqttQos.atLeastOnce);
  }

  void _onDisconnected() {
    // No action needed; autoReconnect handles reconnection.
  }

  void _onMessage(List<MqttReceivedMessage<MqttMessage>> messages) {
    for (final m in messages) {
      if (m.topic != _dataTopic) continue;
      final publish = m.payload as MqttPublishMessage;
      final bytes = publish.payload.message;
      if (bytes == null || bytes.isEmpty) continue;
      try {
        final msg = DeviceToApp.fromBuffer(bytes);
        if (!_controller.isClosed) _controller.add(msg);
      } on Exception {
        // Malformed protobuf — discard.
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
      return;
    }
    if (!message.hasBasicCommandBytes()) return;

    final buffer = typed.Uint8Buffer()..addAll(message.writeToBuffer());
    _client.publishMessage(_cmdTopic, MqttQos.atLeastOnce, buffer);
  }

  @override
  void dispose() {
    _client.disconnect();
    _controller.close();
  }
}
