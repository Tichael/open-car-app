import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_car_app/providers/selected_vehicle_provider.dart';
import 'package:open_car_app/transport/car_transport.dart';
import 'package:open_car_app/transport/mqtt_transport.dart';

final carTransportProvider = Provider<CarTransport>((ref) {
  final vehicle = ref.watch(selectedVehicleProvider)!;
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
