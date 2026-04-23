import 'package:build/build.dart';

import 'src/constants_builder.dart';
import 'src/mqtt_config_builder.dart';
import 'src/proto_builder.dart';

Builder constantsBuilder(BuilderOptions options) => ConstantsBuilder();

Builder mqttConfigBuilder(BuilderOptions options) => MqttConfigBuilder();

Builder protoBuilder(BuilderOptions options) => ProtoBuilder();
