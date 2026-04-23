import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:open_car_app/cars/virtual_car/virtual_car_definition.dart';
import 'package:open_car_app/models/vehicle_definition.dart';

/// All vehicles available for selection in the app.
final availableVehiclesProvider = Provider<List<VehicleDefinition>>(
  (_) => const [VirtualCarDefinition()],
);

/// The currently selected vehicle. Null until the user makes a selection.
final selectedVehicleProvider = StateProvider<VehicleDefinition?>((_) => null);
