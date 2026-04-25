import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:open_car_app/generated/opencar/core/v1/core.pb.dart';

import 'car_transport.dart';

/// ATT error code returned when the device requires bonding.
const _kAttErrorNotPermitted = 0x0f;

class BleCarTransport implements CarTransport {
  final BluetoothDevice _device;
  final String _appToDeviceUuid;
  final String _deviceToAppUuid;

  final _controller = StreamController<DeviceToApp>.broadcast();

  BluetoothCharacteristic? _txChar; // device → app (notify)
  BluetoothCharacteristic? _rxChar; // app → device (write)

  StreamSubscription<List<int>>? _notifySubscription;

  /// Serialises concurrent bonding attempts so Android only shows one pairing
  /// dialog. If a bond is already in progress, callers await this completer
  /// instead of issuing a second [createBond] call.
  Completer<void>? _bondingCompleter;

  BleCarTransport({
    required BluetoothDevice device,
    required String serviceUuid,
    required String appToDeviceCharacteristicUuid,
    required String deviceToAppCharacteristicUuid,
  }) : _device = device,
       _appToDeviceUuid = appToDeviceCharacteristicUuid,
       _deviceToAppUuid = deviceToAppCharacteristicUuid {
    unawaited(_init(serviceUuid));
  }

  Future<void> _init(String serviceUuid) async {
    try {
      // Negotiate the largest usable MTU — firmware note requires 244.
      final mtu = await _device.requestMtu(244);
      dev.log('MTU negotiated: $mtu', name: 'BleTransport');

      final services = _device.servicesList;
      final target = services.firstWhere(
        (s) => s.uuid.toString().toLowerCase() == serviceUuid.toLowerCase(),
      );

      for (final c in target.characteristics) {
        final uuid = c.uuid.toString().toLowerCase();
        if (uuid == _appToDeviceUuid.toLowerCase()) _rxChar = c;
        if (uuid == _deviceToAppUuid.toLowerCase()) _txChar = c;
      }

      if (_txChar == null || _rxChar == null) {
        dev.log(
          'Required characteristics not found in service $serviceUuid',
          name: 'BleTransport',
        );
        _controller.addError(
          StateError('BLE: required characteristics not found in service'),
        );
        return;
      }

      // Notifications were already enabled by BleConnectionNotifier during the
      // readiness check; we only need to subscribe to the value stream here.
      dev.log('Subscribing to device→app characteristic', name: 'BleTransport');
      _notifySubscription = _txChar!.onValueReceived.listen(_onNotify);
    } on Exception catch (e) {
      dev.log('Init error: $e', name: 'BleTransport');
      _controller.addError(e);
    }
  }

  void _onNotify(List<int> bytes) {
    if (bytes.isEmpty) return;
    try {
      final msg = DeviceToApp.fromBuffer(bytes);
      if (kDebugMode)
        dev.log('Received ${bytes.length} bytes', name: 'BleTransport');
      if (!_controller.isClosed) _controller.add(msg);
    } on Exception catch (e) {
      dev.log('Malformed protobuf discarded: $e', name: 'BleTransport');
    }
  }

  @override
  TransportType get transportType => TransportType.ble;

  @override
  Stream<DeviceToApp> get messages => _controller.stream;

  @override
  Future<void> send(AppToDevice message) async {
    final rx = _rxChar;
    if (rx == null) return;

    final bytes = message.writeToBuffer();
    if (kDebugMode)
      dev.log(
        'Sending ${bytes.length} bytes (msgId: ${message.messageId})',
        name: 'BleTransport',
      );

    try {
      await rx.write(bytes, withoutResponse: false);
    } on FlutterBluePlusException catch (e) {
      if (e.code == _kAttErrorNotPermitted) {
        // Device requires bonding — attempt to bond and retry.
        await _handleBondRequired(bytes);
      } else {
        rethrow;
      }
    }
  }

  Future<void> _handleBondRequired(List<int> bytes) async {
    // If bonding is already in progress (triggered by a concurrent send or the
    // notify-setup path), wait for that bond to complete rather than issuing a
    // second createBond() call — which would show a second pairing dialog.
    if (_bondingCompleter != null) {
      dev.log(
        'Bond already in progress — awaiting existing bond',
        name: 'BleTransport',
      );
      await _bondingCompleter!.future;
      // Retry the write now that we are bonded.
      await _rxChar!.write(bytes, withoutResponse: false);
      return;
    }

    _bondingCompleter = Completer<void>();
    dev.log(
      'ATT 0x0F on write — waiting for firmware-initiated bond',
      name: 'BleTransport',
    );
    try {
      // Do NOT call createBond(). The firmware controls its pairing window;
      // calling createBond() while that window is closed causes the firmware
      // to reject the attempt and logs "pairing complete while window closed".
      // The firmware will initiate bonding when its window opens; Android will
      // respond and update bondState to bonded.
      await _device.bondState
          .firstWhere((s) => s == BluetoothBondState.bonded)
          .timeout(const Duration(minutes: 3));
      dev.log('Bond established; retrying write', name: 'BleTransport');

      _bondingCompleter!.complete();
    } on Exception catch (e) {
      _bondingCompleter!.completeError(e);
      rethrow;
    } finally {
      _bondingCompleter = null;
    }

    // Retry once after bonding.
    await _rxChar!.write(bytes, withoutResponse: false);
  }

  @override
  void dispose() {
    _notifySubscription?.cancel();
    _controller.close();
    // Disconnect is managed by BleConnectionNotifier, not here, because the
    // device handle is owned by the notifier.
  }
}
