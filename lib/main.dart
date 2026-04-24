import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_car_app/config/device_identity.dart';
import 'package:open_car_app/providers/ble_source_device_id_provider.dart';
import 'package:open_car_app/screens/vehicle_selection_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final deviceId = await getOrCreateDeviceId();
  runApp(
    ProviderScope(
      overrides: [bleSourceDeviceIdProvider.overrideWithValue(deviceId)],
      child: const OpenCarApp(),
    ),
  );
}

class OpenCarApp extends StatelessWidget {
  const OpenCarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Car',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const VehicleSelectionScreen(),
    );
  }
}
