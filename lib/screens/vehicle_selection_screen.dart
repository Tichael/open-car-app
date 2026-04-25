import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:open_car_app/providers/selected_vehicle_provider.dart';

/// Legacy screen — retained for reference only.
/// Navigation is now handled by [AppEntryRouter] in main.dart.
class VehicleSelectionScreen extends ConsumerWidget {
  const VehicleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicles = ref.watch(availableVehiclesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Select Vehicle')),
      body: ListView.builder(
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          final vehicle = vehicles[index];
          return ListTile(
            title: Text(vehicle.platformName),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => vehicle.buildDashboard()),
              );
            },
          );
        },
      ),
    );
  }
}
