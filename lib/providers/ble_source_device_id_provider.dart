import 'package:flutter_riverpod/flutter_riverpod.dart';

/// UTF-8 bytes of the stable per-device BLE source identifier.
///
/// Overridden in [main.dart] with the value from [getOrCreateDeviceId] before
/// [runApp] is called. The app will throw if this is read without that override.
final bleSourceDeviceIdProvider = Provider<List<int>>(
  (_) => throw StateError(
    'bleSourceDeviceIdProvider was not overridden at startup.',
  ),
);
