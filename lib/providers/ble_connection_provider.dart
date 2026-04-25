import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_car_app/config/paired_vehicle_config.dart';
import 'package:open_car_app/providers/paired_vehicle_provider.dart';
import 'package:open_car_app/providers/selected_vehicle_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// ATT error code indicating the device requires bonding before the operation
/// can proceed.
const _kAttErrorNotPermitted = 0x0f;

/// Represents the current state of the BLE connection lifecycle.
sealed class BleConnectionState {
  const BleConnectionState();
}

/// Scanning for the car's BLE service advertisement.
/// Emitted only by [PairingWizardScreen] during the pairing flow; not emitted
/// by [BleConnectionNotifier] after a device is already paired.
class BleScanning extends BleConnectionState {
  const BleScanning();
}

/// Establishing BLE connection — connecting to the known device and
/// initialising characteristics. MQTT remains the active transport.
class BleConnecting extends BleConnectionState {
  final BluetoothDevice device;
  BleConnecting(this.device);
}

/// Connected to the car over BLE and fully ready for communication:
/// services discovered, required characteristics resolved, notifications
/// enabled. The transport provider switches to BLE on this state.
class BleReady extends BleConnectionState {
  final BluetoothDevice device;
  BleReady(this.device);
}

/// Not connected and not attempting to connect (BLE unavailable, disabled,
/// no paired device, or device paired via HTTP transport).
/// [warning] carries a human-readable reason when set.
class BleDisconnected extends BleConnectionState {
  final String? warning;
  BleDisconnected({this.warning});
}

class BleConnectionNotifier extends Notifier<BleConnectionState> {
  StreamSubscription<BluetoothConnectionState>? _connectionSubscription;
  StreamSubscription<BluetoothAdapterState>? _adapterSubscription;
  BluetoothDevice? _connectedDevice;
  bool _connecting = false;
  Timer? _reconnectTimer;

  @override
  BleConnectionState build() {
    final config = ref.watch(pairedVehicleProvider);

    // No paired device, or user prefers HTTP — BLE not needed.
    if (config == null ||
        config.transportPreference == TransportPreference.http ||
        config.bleRemoteId.isEmpty) {
      return BleDisconnected();
    }

    ref.onDispose(_cleanup);
    unawaited(_initConnection(config.bleRemoteId));
    return BleConnecting(BluetoothDevice.fromId(config.bleRemoteId));
  }

  Future<void> _initConnection(String remoteId) async {
    final granted = await _requestPermissions();
    if (!granted) {
      dev.log('Bluetooth permission denied', name: 'BleConnection');
      state = BleDisconnected(
        warning: 'Bluetooth permission denied. Grant it in app settings.',
      );
      return;
    }

    // Watch adapter state so we connect (or reconnect) when BT comes on.
    _adapterSubscription = FlutterBluePlus.adapterState.listen((adapterState) {
      dev.log('Adapter state: $adapterState', name: 'BleConnection');
      if (adapterState == BluetoothAdapterState.on) {
        _connectDirectly(remoteId);
      } else if (adapterState == BluetoothAdapterState.off) {
        _reconnectTimer?.cancel();
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

  Future<void> _connectDirectly(String remoteId) async {
    if (_connecting) return;
    _connecting = true;
    _reconnectTimer?.cancel();

    final device = BluetoothDevice.fromId(remoteId);
    state = BleConnecting(device);

    try {
      dev.log('Connecting to $remoteId', name: 'BleConnection');
      await device.connect(autoConnect: false);
      await device.discoverServices();

      dev.log(
        'Initialising BLE transport layer for $remoteId',
        name: 'BleConnection',
      );

      final vehicle = ref.read(selectedVehicleProvider);
      if (vehicle == null) {
        state = BleDisconnected();
        _connecting = false;
        return;
      }

      await _initCharacteristics(
        device,
        serviceUuid: vehicle.bleServiceUuid,
        appToDeviceUuid: vehicle.bleAppToDeviceCharacteristicUuid,
        deviceToAppUuid: vehicle.bleDeviceToAppCharacteristicUuid,
      );

      _connectedDevice = device;
      dev.log('BLE ready: $remoteId', name: 'BleConnection');
      state = BleReady(device);
      _connecting = false;

      // Watch for disconnection and retry.
      _connectionSubscription = device.connectionState.listen((
        connectionState,
      ) {
        if (connectionState == BluetoothConnectionState.disconnected) {
          dev.log(
            'Disconnected from $remoteId — will retry',
            name: 'BleConnection',
          );
          _connectedDevice = null;
          _connecting = false;
          _connectionSubscription?.cancel();
          _connectionSubscription = null;
          // Retry after a short back-off rather than immediately — gives
          // the radio time to settle after unexpected disconnects.
          _scheduleReconnect(remoteId);
        }
      });
    } on Exception catch (e) {
      dev.log('Connect/init failed: $e — will retry', name: 'BleConnection');
      _connecting = false;
      state = BleConnecting(device); // stay in connecting state during retry
      _scheduleReconnect(remoteId);
    }
  }

  void _scheduleReconnect(String remoteId) {
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(
      const Duration(seconds: 5),
      () => _connectDirectly(remoteId),
    );
  }

  /// Verifies required characteristics and enables notifications on the
  /// device→app characteristic. Throws on any failure.
  Future<void> _initCharacteristics(
    BluetoothDevice device, {
    required String serviceUuid,
    required String appToDeviceUuid,
    required String deviceToAppUuid,
  }) async {
    final services = device.servicesList;
    final target = services.firstWhere(
      (s) => s.uuid.toString().toLowerCase() == serviceUuid.toLowerCase(),
      orElse: () => throw StateError('BLE service $serviceUuid not found'),
    );

    BluetoothCharacteristic? txChar;
    for (final c in target.characteristics) {
      final uuid = c.uuid.toString().toLowerCase();
      if (uuid == deviceToAppUuid.toLowerCase()) txChar = c;
    }

    if (txChar == null) {
      throw StateError(
        'Required BLE characteristics not found in service $serviceUuid',
      );
    }

    // Enable notifications. If the characteristic is secured and bonding has
    // not yet completed, setNotifyValue will throw ATT 0x0F. The device
    // controls its pairing window; we wait passively for the bond to complete
    // rather than calling createBond(), which can show a spurious second
    // pairing dialog if the window is not open.
    try {
      await txChar.setNotifyValue(true);
      dev.log(
        'Notifications enabled on device→app characteristic',
        name: 'BleConnection',
      );
    } on FlutterBluePlusException catch (e) {
      if (e.code != _kAttErrorNotPermitted) rethrow;
      dev.log(
        'setNotifyValue requires bonding — waiting for bond to complete',
        name: 'BleConnection',
      );
      await device.bondState
          .firstWhere((s) => s == BluetoothBondState.bonded)
          .timeout(const Duration(minutes: 3));
      await txChar.setNotifyValue(true);
      dev.log('Notifications enabled after bonding', name: 'BleConnection');
    }
  }

  void _cleanup() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _adapterSubscription?.cancel();
    _adapterSubscription = null;
    _connectionSubscription?.cancel();
    _connectionSubscription = null;
    _connectedDevice?.disconnect();
    _connectedDevice = null;
    _connecting = false;
  }
}

final bleConnectionProvider =
    NotifierProvider<BleConnectionNotifier, BleConnectionState>(
      BleConnectionNotifier.new,
    );
