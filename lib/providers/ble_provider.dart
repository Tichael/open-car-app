import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Singleton [FlutterReactiveBle] instance shared across the app.
///
/// Injected as a provider so it can be overridden in tests.
final bleProvider = Provider<FlutterReactiveBle>((ref) => FlutterReactiveBle());
