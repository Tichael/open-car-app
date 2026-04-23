import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_car_app/screens/vehicle_selection_screen.dart';

void main() {
  runApp(const ProviderScope(child: OpenCarApp()));
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
