import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

const _kPrefsKey = 'ble_source_device_id';

/// Returns the stable per-device BLE source identifier, generating and
/// persisting it on first call.
///
/// Returns a tuple of `(idBytes, isNew)` where `isNew` is true when the ID
/// was just created.
///
/// Call once at app startup (before [runApp]) and pass the result into
/// [ProviderScope] via [bleSourceDeviceIdProvider].
Future<(List<int>, bool)> getOrCreateDeviceId() async {
  final prefs = await SharedPreferences.getInstance();
  var id = prefs.getString(_kPrefsKey);
  final isNew = id == null;
  if (isNew) {
    id = const Uuid().v4();
    await prefs.setString(_kPrefsKey, id);
  }
  return (utf8.encode(id), isNew);
}
