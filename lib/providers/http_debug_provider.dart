import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_car_app/providers/car_transport_provider.dart';
import 'package:open_car_app/transport/http_transport.dart';

/// Whether the HTTP debug transport is currently enabled.
/// Toggled from the debug section of the vehicle dashboard.
/// Only meaningful in debug builds — the provider still exists in release
/// builds but the UI that reads it is guarded by [kDebugMode].
final httpDebugEnabledProvider = StateProvider<bool>((ref) => false);

/// Returns the active [HttpCarTransport] when the HTTP debug transport is
/// selected, or null when another transport is active.
///
/// Vehicle screens use this to expose pairing controls without having to
/// cast [carTransportProvider] themselves.
final httpCarTransportProvider = Provider<HttpCarTransport?>((ref) {
  final transport = ref.watch(carTransportProvider);
  return transport is HttpCarTransport ? transport : null;
});
