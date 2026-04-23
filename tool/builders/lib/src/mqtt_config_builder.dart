import 'dart:convert';

import 'package:build/build.dart';
import 'package:toml/toml.dart';

class MqttConfigBuilder implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => const {
    'config.toml.example': ['lib/config/mqtt_broker_config.g.dart'],
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    // Always read the example file for defaults.
    final exampleId = buildStep.inputId;
    var source = await buildStep.readAsString(exampleId);

    // If a local config.toml exists, use it instead (developer / CI override).
    final overrideId = AssetId(exampleId.package, 'config.toml');
    if (await buildStep.canRead(overrideId)) {
      source = await buildStep.readAsString(overrideId);
    }

    final doc = TomlDocument.parse(source);
    final config = doc.toMap();

    final broker = _map(config['broker'], 'broker');
    final client = _map(config['client'], 'client');

    final host = _string(broker['host'], 'broker.host');
    final port = _int(broker['port'], 'broker.port');
    final username = _string(broker['username'], 'broker.username');
    final password = _string(broker['password'], 'broker.password');
    final clientId = _string(client['client_id'], 'client.client_id');

    final outputId = AssetId(
      exampleId.package,
      'lib/config/mqtt_broker_config.g.dart',
    );

    final buffer = StringBuffer()
      ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND.')
      ..writeln('// Source: config.toml (or config.toml.example as fallback)')
      ..writeln()
      ..writeln('const String kMqttBrokerHost = ${jsonEncode(host)};')
      ..writeln('const int kMqttBrokerPort = $port;')
      ..writeln('const String kMqttUsername = ${jsonEncode(username)};')
      ..writeln('const String kMqttPassword = ${jsonEncode(password)};')
      ..writeln('const String kMqttClientId = ${jsonEncode(clientId)};');

    await buildStep.writeAsString(outputId, buffer.toString());
  }

  Map<String, Object?> _map(Object? value, String field) {
    if (value is Map<String, Object?>) return value;
    throw StateError('Expected [$field] to be a table.');
  }

  String _string(Object? value, String field) {
    if (value is String) return value;
    throw StateError('Expected [$field] to be a string.');
  }

  int _int(Object? value, String field) {
    if (value is int) return value;
    throw StateError('Expected [$field] to be an int.');
  }
}
