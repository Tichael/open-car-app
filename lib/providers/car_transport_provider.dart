import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_car_app/config/mqtt_broker_config.g.dart';
import 'package:open_car_app/providers/ble_connection_provider.dart';
import 'package:open_car_app/providers/http_debug_provider.dart';
import 'package:open_car_app/providers/selected_vehicle_provider.dart';
import 'package:open_car_app/transport/ble_transport.dart';
import 'package:open_car_app/transport/car_transport.dart';
import 'package:open_car_app/transport/http_transport.dart';
import 'package:open_car_app/transport/mqtt_transport.dart';

final carTransportProvider = Provider<CarTransport>((ref) {
  final vehicle = ref.watch(selectedVehicleProvider)!;

  // Debug-only: HTTP transport overrides BLE when enabled from the debug menu.
  if (kDebugMode && ref.watch(httpDebugEnabledProvider)) {
    final transport = HttpCarTransport(
      host: kDebugServerHost,
      port: kDebugServerPort,
      pollingIntervalMs: kDebugServerPollingIntervalMs,
    );
    ref.onDispose(transport.dispose);
    return transport;
  }

  final ble = ref.watch(bleConnectionProvider);

  if (ble is BleConnected) {
    final transport = BleCarTransport(
      device: ble.device,
      serviceUuid: vehicle.bleServiceUuid,
      appToDeviceCharacteristicUuid: vehicle.bleAppToDeviceCharacteristicUuid,
      deviceToAppCharacteristicUuid: vehicle.bleDeviceToAppCharacteristicUuid,
    );
    ref.onDispose(transport.dispose);
    return transport;
  }

  final transport = MqttCarTransport(
    commandTopicTemplate: vehicle.mqttCommandTopicTemplate,
    dataTopicTemplate: vehicle.mqttDataTopicTemplate,
  );
  ref.onDispose(transport.dispose);
  return transport;
});

final transportTypeProvider = Provider<TransportType>(
  (ref) => ref.watch(carTransportProvider).transportType,
);
