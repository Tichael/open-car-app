import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_car_app/providers/selected_vehicle_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// Represents the current state of the BLE connection lifecycle.
sealed class BleConnectionState {}

/// Actively scanning for the car's BLE service.
class BleScanning extends BleConnectionState {}

/// Connected to the car over BLE.
class BleConnected extends BleConnectionState {
  final BluetoothDevice device;
  BleConnected(this.device);
}

/// Not connected and not scanning (BLE unavailable on this device or disabled).
/// [warning] is set when a stale LTK is detected — the user should forget the
/// device in Android Bluetooth settings and re-pair.
class BleDisconnected extends BleConnectionState {
  final String? warning;
  BleDisconnected({this.warning});
}

class BleConnectionNotifier extends Notifier<BleConnectionState> {
  StreamSubscription<List<ScanResult>>? _scanSubscription;
  StreamSubscription<BluetoothConnectionState>? _connectionSubscription;
  StreamSubscription<BluetoothAdapterState>? _adapterSubscription;
  BluetoothDevice? _connectedDevice;

  @override
  BleConnectionState build() {
    final vehicle = ref.watch(selectedVehicleProvider);
    if (vehicle == null) return BleDisconnected();

    ref.onDispose(_cleanup);
    unawaited(_initScan(vehicle.bleServiceUuid));
    return BleScanning();
  }

  Future<void> _initScan(String serviceUuid) async {
    // Request runtime permissions before scanning (required on Android 12+).
    final granted = await _requestPermissions();
    if (!granted) {
      state = BleDisconnected(
        warning: 'Bluetooth permission denied. Grant it in app settings.',
      );
      return;
    }

    // Watch adapter state so we restart scanning if BT is toggled on later.
    _adapterSubscription = FlutterBluePlus.adapterState.listen((adapterState) {
      if (adapterState == BluetoothAdapterState.on) {
        // BT just came on (or was already on) — start scanning.
        _startScan(serviceUuid);
      } else if (adapterState == BluetoothAdapterState.off) {
        _cleanupScan();
        state = BleDisconnected(warning: 'Bluetooth is off.');
      }
    });
  }

  Future<bool> _requestPermissions() async {
    final statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
    ].request();
    return statuses.values.every((s) => s.isGranted);
  }

  void _startScan(String serviceUuid) {
    _cleanupScan();

    FlutterBluePlus.startScan(
      withServices: [Guid(serviceUuid)],
      // Continuous scan — stops only when we connect.
    );

    _scanSubscription = FlutterBluePlus.scanResults.listen(
      (results) {
        if (results.isEmpty) return;
        // Take the first matching device.
        _connectToDevice(results.first.device);
      },
      onError: (_) {
        state = BleDisconnected();
      },
    );

    state = BleScanning();
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    // Stop scanning before connecting.
    await FlutterBluePlus.stopScan();
    _cleanupScan();

    try {
      await device.connect(autoConnect: false);
      await device.discoverServices();

      _connectedDevice = device;
      state = BleConnected(device);

      // Watch for disconnection so we can fall back to MQTT and re-scan.
      _connectionSubscription =
          device.connectionState.listen((connectionState) {
        if (connectionState == BluetoothConnectionState.disconnected) {
          _connectedDevice = null;
          _connectionSubscription?.cancel();
          _connectionSubscription = null;

          final vehicle = ref.read(selectedVehicleProvider);
          if (vehicle != null) {
            _startScan(vehicle.bleServiceUuid);
          } else {
            state = BleDisconnected();
          }
        }
      });
    } on Exception {
      // Connection failed — restart scan to try again.
      final vehicle = ref.read(selectedVehicleProvider);
      if (vehicle != null) {
        _startScan(vehicle.bleServiceUuid);
      } else {
        state = BleDisconnected();
      }
    }
  }

  void _cleanupScan() {
    _scanSubscription?.cancel();
    _scanSubscription = null;
    FlutterBluePlus.stopScan();
  }

  void _cleanup() {
    _cleanupScan();
    _adapterSubscription?.cancel();
    _adapterSubscription = null;
    _connectionSubscription?.cancel();
    _connectionSubscription = null;
    _connectedDevice?.disconnect();
    _connectedDevice = null;
  }
}

final bleConnectionProvider =
    NotifierProvider<BleConnectionNotifier, BleConnectionState>(
  BleConnectionNotifier.new,
);
