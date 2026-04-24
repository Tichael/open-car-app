import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protobuf/protobuf.dart';
import 'package:open_car_app/generated/opencar/core/v1/core.pb.dart';
import 'package:open_car_app/generated/opencar/core/v1/system.pb.dart';
import 'package:open_car_app/providers/ble_source_device_id_provider.dart';
import 'package:open_car_app/providers/car_transport_provider.dart';
import 'package:open_car_app/providers/selected_vehicle_provider.dart';
import 'package:open_car_app/models/vehicle_definition.dart';
import 'package:open_car_app/transport/car_transport.dart';

class VehicleSnapshot {
  /// Decoded vehicle-specific basic state. Cast to the vehicle's BasicState
  /// type in the vehicle's own screen (e.g. `snapshot.basicState as BasicState`).
  final GeneratedMessage basicState;

  /// Decoded vehicle-specific advanced state. Cast in the vehicle's own screen.
  final GeneratedMessage advancedState;

  /// Core system state (firmware version, hardware type, uptime).
  /// Null until the first BLE state update is received.
  final SystemState? system;

  const VehicleSnapshot({
    required this.basicState,
    required this.advancedState,
    this.system,
  });

  VehicleSnapshot copyWith({
    GeneratedMessage? basicState,
    GeneratedMessage? advancedState,
    SystemState? system,
  }) {
    return VehicleSnapshot(
      basicState: basicState ?? this.basicState,
      advancedState: advancedState ?? this.advancedState,
      system: system ?? this.system,
    );
  }
}

class VehicleStateNotifier extends Notifier<VehicleSnapshot> {
  StreamSubscription<DeviceToApp>? _subscription;
  int _nextMessageId = 0;

  @override
  VehicleSnapshot build() {
    final vehicle = ref.watch(selectedVehicleProvider)!;
    final transport = ref.watch(carTransportProvider);

    _subscription = transport.messages.listen(_onMessage);
    ref.onDispose(() => _subscription?.cancel());

    // Initialise with empty (all-default) instances of the vehicle's proto types
    // so that the vehicle's screen can safely cast without a null check.
    return VehicleSnapshot(
      basicState: vehicle.decodeBasicState(const []),
      advancedState: vehicle.decodeAdvancedState(const []),
    );
  }

  void _onMessage(DeviceToApp msg) {
    if (!msg.hasStateUpdate()) return;

    final vehicle = ref.read(selectedVehicleProvider)!;
    final update = msg.stateUpdate;
    var current = state;

    if (update.hasVehicleState()) {
      final vs = update.vehicleState;

      if (vs.basicStateBytes.isNotEmpty) {
        // Decode once; merge into a fresh copy of the current state.
        final merged = vehicle.decodeBasicState(const [])
          ..mergeFromMessage(current.basicState)
          ..mergeFromBuffer(vs.basicStateBytes);
        current = current.copyWith(basicState: merged);
      }

      if (vs.advancedStateBytes.isNotEmpty) {
        final merged = vehicle.decodeAdvancedState(const [])
          ..mergeFromMessage(current.advancedState)
          ..mergeFromBuffer(vs.advancedStateBytes);
        current = current.copyWith(advancedState: merged);
      }
    }

    if (update.hasSystemState()) {
      final merged = SystemState()
        ..mergeFromMessage(current.system ?? SystemState())
        ..mergeFromMessage(update.systemState);
      current = current.copyWith(system: merged);
    }

    state = current;
  }

  /// Send a serialised basic command for the active vehicle.
  /// The caller (vehicle-specific screen) is responsible for serialising the
  /// vehicle's own proto command type: `myCommand.writeToBuffer()`.
  Future<void> sendBasicCommand(List<int> commandBytes) {
    return _send(AppToDevice(
      messageId: Int64(_nextMessageId++),
      platformId: vehicle.platformId,
      basicCommandBytes: commandBytes,
    ));
  }

  /// Send a serialised advanced command for the active vehicle.
  /// Only meaningful over BLE; the BLE transport sends all envelope types.
  Future<void> sendAdvancedCommand(List<int> commandBytes) {
    return _send(AppToDevice(
      messageId: Int64(_nextMessageId++),
      platformId: vehicle.platformId,
      advancedCommandBytes: commandBytes,
    ));
  }

  Future<void> _send(AppToDevice envelope) {
    final transportType = ref.read(transportTypeProvider);
    if (transportType == TransportType.ble ||
        transportType == TransportType.http) {
      envelope.sourceDeviceId = ref.read(bleSourceDeviceIdProvider);
    }
    return ref.read(carTransportProvider).send(envelope);
  }

  VehicleDefinition get vehicle => ref.read(selectedVehicleProvider)!;
}

final vehicleStateProvider =
    NotifierProvider<VehicleStateNotifier, VehicleSnapshot>(
        VehicleStateNotifier.new);
