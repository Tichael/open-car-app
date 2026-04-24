import 'dart:async';

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

  BleCarTransport({
    required BluetoothDevice device,
    required String serviceUuid,
    required String appToDeviceCharacteristicUuid,
    required String deviceToAppCharacteristicUuid,
  })  : _device = device,
        _appToDeviceUuid = appToDeviceCharacteristicUuid,
        _deviceToAppUuid = deviceToAppCharacteristicUuid {
    unawaited(_init(serviceUuid));
  }

  Future<void> _init(String serviceUuid) async {
    try {
      // Negotiate the largest usable MTU — firmware note requires 244.
      await _device.requestMtu(244);

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
        _controller.addError(
          StateError('BLE: required characteristics not found in service'),
        );
        return;
      }

      // Enable notifications — Android doesn't do this automatically.
      await _txChar!.setNotifyValue(true);
      // Use onValueReceived (not lastValueStream) so we only process newly
      // arrived notifications, never a stale cached value from a prior session.
      _notifySubscription = _txChar!.onValueReceived.listen(_onNotify);
    } on Exception catch (e) {
      _controller.addError(e);
    }
  }

  void _onNotify(List<int> bytes) {
    if (bytes.isEmpty) return;
    try {
      final msg = DeviceToApp.fromBuffer(bytes);
      if (!_controller.isClosed) _controller.add(msg);
    } on Exception {
      // Malformed protobuf — discard.
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
    await _device.createBond();

    // Wait until the bond is fully established.
    await _device.bondState
        .firstWhere((s) => s == BluetoothBondState.bonded)
        .timeout(const Duration(seconds: 30));

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
