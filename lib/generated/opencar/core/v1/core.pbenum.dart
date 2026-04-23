//
//  Generated code. Do not modify.
//  source: opencar/core/v1/core.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// High-level status for a command execution attempt.
class CommandStatusCode extends $pb.ProtobufEnum {
  static const CommandStatusCode COMMAND_STATUS_CODE_UNSPECIFIED = CommandStatusCode._(0, _omitEnumNames ? '' : 'COMMAND_STATUS_CODE_UNSPECIFIED');
  static const CommandStatusCode COMMAND_STATUS_CODE_OK = CommandStatusCode._(1, _omitEnumNames ? '' : 'COMMAND_STATUS_CODE_OK');
  static const CommandStatusCode COMMAND_STATUS_CODE_FAILED = CommandStatusCode._(2, _omitEnumNames ? '' : 'COMMAND_STATUS_CODE_FAILED');
  static const CommandStatusCode COMMAND_STATUS_CODE_REJECTED_NOT_CONTROLLER = CommandStatusCode._(3, _omitEnumNames ? '' : 'COMMAND_STATUS_CODE_REJECTED_NOT_CONTROLLER');

  static const $core.List<CommandStatusCode> values = <CommandStatusCode> [
    COMMAND_STATUS_CODE_UNSPECIFIED,
    COMMAND_STATUS_CODE_OK,
    COMMAND_STATUS_CODE_FAILED,
    COMMAND_STATUS_CODE_REJECTED_NOT_CONTROLLER,
  ];

  static final $core.Map<$core.int, CommandStatusCode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CommandStatusCode? valueOf($core.int value) => _byValue[value];

  const CommandStatusCode._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
