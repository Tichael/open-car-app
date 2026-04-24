import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

const _kPrefsKey = 'ble_source_device_id';

/// Returns the stable per-device BLE source identifier, generating and
/// persisting it on first call.
///
/// Call once at app startup (before [runApp]) and pass the result into
/// [ProviderScope] via [bleSourceDeviceIdProvider].
Future<List<int>> getOrCreateDeviceId() async {
  final prefs = await SharedPreferences.getInstance();
  var id = prefs.getString(_kPrefsKey);
  if (id == null) {
    id = const Uuid().v4();
    await prefs.setString(_kPrefsKey, id);
  }
  return utf8.encode(id);
}
