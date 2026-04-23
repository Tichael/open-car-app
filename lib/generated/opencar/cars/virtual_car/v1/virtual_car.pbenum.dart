//
//  Generated code. Do not modify.
//  source: opencar/cars/virtual_car/v1/virtual_car.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Represent the different gears possible in the car
class AdvancedState_Gear extends $pb.ProtobufEnum {
  static const AdvancedState_Gear GEAR_UNSPECIFIED = AdvancedState_Gear._(0, _omitEnumNames ? '' : 'GEAR_UNSPECIFIED');
  static const AdvancedState_Gear GEAR_PARK = AdvancedState_Gear._(1, _omitEnumNames ? '' : 'GEAR_PARK');
  static const AdvancedState_Gear GEAR_REVERSE = AdvancedState_Gear._(2, _omitEnumNames ? '' : 'GEAR_REVERSE');
  static const AdvancedState_Gear GEAR_NEUTRAL = AdvancedState_Gear._(3, _omitEnumNames ? '' : 'GEAR_NEUTRAL');
  static const AdvancedState_Gear GEAR_DRIVE = AdvancedState_Gear._(4, _omitEnumNames ? '' : 'GEAR_DRIVE');

  static const $core.List<AdvancedState_Gear> values = <AdvancedState_Gear> [
    GEAR_UNSPECIFIED,
    GEAR_PARK,
    GEAR_REVERSE,
    GEAR_NEUTRAL,
    GEAR_DRIVE,
  ];

  static final $core.Map<$core.int, AdvancedState_Gear> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AdvancedState_Gear? valueOf($core.int value) => _byValue[value];

  const AdvancedState_Gear._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
