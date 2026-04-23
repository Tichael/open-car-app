//
//  Generated code. Do not modify.
//  source: opencar/core/v1/core.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use commandStatusCodeDescriptor instead')
const CommandStatusCode$json = {
  '1': 'CommandStatusCode',
  '2': [
    {'1': 'COMMAND_STATUS_CODE_UNSPECIFIED', '2': 0},
    {'1': 'COMMAND_STATUS_CODE_OK', '2': 1},
    {'1': 'COMMAND_STATUS_CODE_FAILED', '2': 2},
    {'1': 'COMMAND_STATUS_CODE_REJECTED_NOT_CONTROLLER', '2': 3},
  ],
};

/// Descriptor for `CommandStatusCode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List commandStatusCodeDescriptor = $convert.base64Decode(
    'ChFDb21tYW5kU3RhdHVzQ29kZRIjCh9DT01NQU5EX1NUQVRVU19DT0RFX1VOU1BFQ0lGSUVEEA'
    'ASGgoWQ09NTUFORF9TVEFUVVNfQ09ERV9PSxABEh4KGkNPTU1BTkRfU1RBVFVTX0NPREVfRkFJ'
    'TEVEEAISLworQ09NTUFORF9TVEFUVVNfQ09ERV9SRUpFQ1RFRF9OT1RfQ09OVFJPTExFUhAD');

@$core.Deprecated('Use appToDeviceDescriptor instead')
const AppToDevice$json = {
  '1': 'AppToDevice',
  '2': [
    {'1': 'message_id', '3': 1, '4': 1, '5': 4, '10': 'messageId'},
    {'1': 'platform_id', '3': 2, '4': 1, '5': 13, '10': 'platformId'},
    {'1': 'source_device_id', '3': 6, '4': 1, '5': 12, '10': 'sourceDeviceId'},
    {'1': 'system_command', '3': 3, '4': 1, '5': 11, '6': '.opencar.core.v1.SystemCommand', '9': 0, '10': 'systemCommand'},
    {'1': 'basic_command_bytes', '3': 4, '4': 1, '5': 12, '9': 0, '10': 'basicCommandBytes'},
    {'1': 'advanced_command_bytes', '3': 5, '4': 1, '5': 12, '9': 0, '10': 'advancedCommandBytes'},
  ],
  '8': [
    {'1': 'payload'},
  ],
};

/// Descriptor for `AppToDevice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List appToDeviceDescriptor = $convert.base64Decode(
    'CgtBcHBUb0RldmljZRIdCgptZXNzYWdlX2lkGAEgASgEUgltZXNzYWdlSWQSHwoLcGxhdGZvcm'
    '1faWQYAiABKA1SCnBsYXRmb3JtSWQSKAoQc291cmNlX2RldmljZV9pZBgGIAEoDFIOc291cmNl'
    'RGV2aWNlSWQSRwoOc3lzdGVtX2NvbW1hbmQYAyABKAsyHi5vcGVuY2FyLmNvcmUudjEuU3lzdG'
    'VtQ29tbWFuZEgAUg1zeXN0ZW1Db21tYW5kEjAKE2Jhc2ljX2NvbW1hbmRfYnl0ZXMYBCABKAxI'
    'AFIRYmFzaWNDb21tYW5kQnl0ZXMSNgoWYWR2YW5jZWRfY29tbWFuZF9ieXRlcxgFIAEoDEgAUh'
    'RhZHZhbmNlZENvbW1hbmRCeXRlc0IJCgdwYXlsb2Fk');

@$core.Deprecated('Use deviceToAppDescriptor instead')
const DeviceToApp$json = {
  '1': 'DeviceToApp',
  '2': [
    {'1': 'timestamp_ms', '3': 1, '4': 1, '5': 4, '10': 'timestampMs'},
    {'1': 'platform_id', '3': 2, '4': 1, '5': 13, '10': 'platformId'},
    {'1': 'state_update', '3': 3, '4': 1, '5': 11, '6': '.opencar.core.v1.StateUpdate', '9': 0, '10': 'stateUpdate'},
    {'1': 'command_response', '3': 4, '4': 1, '5': 11, '6': '.opencar.core.v1.CommandResponse', '9': 0, '10': 'commandResponse'},
    {'1': 'can_debug_update', '3': 5, '4': 1, '5': 11, '6': '.opencar.core.v1.CanDebugUpdate', '9': 0, '10': 'canDebugUpdate'},
  ],
  '8': [
    {'1': 'payload'},
  ],
};

/// Descriptor for `DeviceToApp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceToAppDescriptor = $convert.base64Decode(
    'CgtEZXZpY2VUb0FwcBIhCgx0aW1lc3RhbXBfbXMYASABKARSC3RpbWVzdGFtcE1zEh8KC3BsYX'
    'Rmb3JtX2lkGAIgASgNUgpwbGF0Zm9ybUlkEkEKDHN0YXRlX3VwZGF0ZRgDIAEoCzIcLm9wZW5j'
    'YXIuY29yZS52MS5TdGF0ZVVwZGF0ZUgAUgtzdGF0ZVVwZGF0ZRJNChBjb21tYW5kX3Jlc3Bvbn'
    'NlGAQgASgLMiAub3BlbmNhci5jb3JlLnYxLkNvbW1hbmRSZXNwb25zZUgAUg9jb21tYW5kUmVz'
    'cG9uc2USSwoQY2FuX2RlYnVnX3VwZGF0ZRgFIAEoCzIfLm9wZW5jYXIuY29yZS52MS5DYW5EZW'
    'J1Z1VwZGF0ZUgAUg5jYW5EZWJ1Z1VwZGF0ZUIJCgdwYXlsb2Fk');

@$core.Deprecated('Use stateUpdateDescriptor instead')
const StateUpdate$json = {
  '1': 'StateUpdate',
  '2': [
    {'1': 'system_state', '3': 1, '4': 1, '5': 11, '6': '.opencar.core.v1.SystemState', '10': 'systemState'},
    {'1': 'vehicle_state', '3': 2, '4': 1, '5': 11, '6': '.opencar.core.v1.VehicleState', '10': 'vehicleState'},
  ],
};

/// Descriptor for `StateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stateUpdateDescriptor = $convert.base64Decode(
    'CgtTdGF0ZVVwZGF0ZRI/CgxzeXN0ZW1fc3RhdGUYASABKAsyHC5vcGVuY2FyLmNvcmUudjEuU3'
    'lzdGVtU3RhdGVSC3N5c3RlbVN0YXRlEkIKDXZlaGljbGVfc3RhdGUYAiABKAsyHS5vcGVuY2Fy'
    'LmNvcmUudjEuVmVoaWNsZVN0YXRlUgx2ZWhpY2xlU3RhdGU=');

@$core.Deprecated('Use vehicleStateDescriptor instead')
const VehicleState$json = {
  '1': 'VehicleState',
  '2': [
    {'1': 'basic_state_bytes', '3': 1, '4': 1, '5': 12, '10': 'basicStateBytes'},
    {'1': 'advanced_state_bytes', '3': 2, '4': 1, '5': 12, '10': 'advancedStateBytes'},
  ],
};

/// Descriptor for `VehicleState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vehicleStateDescriptor = $convert.base64Decode(
    'CgxWZWhpY2xlU3RhdGUSKgoRYmFzaWNfc3RhdGVfYnl0ZXMYASABKAxSD2Jhc2ljU3RhdGVCeX'
    'RlcxIwChRhZHZhbmNlZF9zdGF0ZV9ieXRlcxgCIAEoDFISYWR2YW5jZWRTdGF0ZUJ5dGVz');

@$core.Deprecated('Use commandResponseDescriptor instead')
const CommandResponse$json = {
  '1': 'CommandResponse',
  '2': [
    {'1': 'message_id', '3': 1, '4': 1, '5': 4, '10': 'messageId'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'basic_response_data', '3': 5, '4': 1, '5': 12, '9': 0, '10': 'basicResponseData'},
    {'1': 'advanced_response_bytes', '3': 6, '4': 1, '5': 12, '9': 0, '10': 'advancedResponseBytes'},
    {'1': 'status_code', '3': 7, '4': 1, '5': 14, '6': '.opencar.core.v1.CommandStatusCode', '10': 'statusCode'},
  ],
  '8': [
    {'1': 'response_data'},
  ],
};

/// Descriptor for `CommandResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commandResponseDescriptor = $convert.base64Decode(
    'Cg9Db21tYW5kUmVzcG9uc2USHQoKbWVzc2FnZV9pZBgBIAEoBFIJbWVzc2FnZUlkEhgKB3N1Y2'
    'Nlc3MYAiABKAhSB3N1Y2Nlc3MSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdl'
    'EjAKE2Jhc2ljX3Jlc3BvbnNlX2RhdGEYBSABKAxIAFIRYmFzaWNSZXNwb25zZURhdGESOAoXYW'
    'R2YW5jZWRfcmVzcG9uc2VfYnl0ZXMYBiABKAxIAFIVYWR2YW5jZWRSZXNwb25zZUJ5dGVzEkMK'
    'C3N0YXR1c19jb2RlGAcgASgOMiIub3BlbmNhci5jb3JlLnYxLkNvbW1hbmRTdGF0dXNDb2RlUg'
    'pzdGF0dXNDb2RlQg8KDXJlc3BvbnNlX2RhdGE=');

@$core.Deprecated('Use canDebugUpdateDescriptor instead')
const CanDebugUpdate$json = {
  '1': 'CanDebugUpdate',
  '2': [
    {'1': 'frames', '3': 1, '4': 3, '5': 11, '6': '.opencar.core.v1.CanDebugFrame', '10': 'frames'},
    {'1': 'dropped_frames', '3': 2, '4': 1, '5': 13, '10': 'droppedFrames'},
  ],
};

/// Descriptor for `CanDebugUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List canDebugUpdateDescriptor = $convert.base64Decode(
    'Cg5DYW5EZWJ1Z1VwZGF0ZRI2CgZmcmFtZXMYASADKAsyHi5vcGVuY2FyLmNvcmUudjEuQ2FuRG'
    'VidWdGcmFtZVIGZnJhbWVzEiUKDmRyb3BwZWRfZnJhbWVzGAIgASgNUg1kcm9wcGVkRnJhbWVz');

@$core.Deprecated('Use canDebugFrameDescriptor instead')
const CanDebugFrame$json = {
  '1': 'CanDebugFrame',
  '2': [
    {'1': 'timestamp_ms', '3': 1, '4': 1, '5': 4, '10': 'timestampMs'},
    {'1': 'bus_id', '3': 2, '4': 1, '5': 13, '10': 'busId'},
    {'1': 'can_id', '3': 3, '4': 1, '5': 13, '10': 'canId'},
    {'1': 'is_extended_id', '3': 4, '4': 1, '5': 8, '10': 'isExtendedId'},
    {'1': 'data', '3': 5, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `CanDebugFrame`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List canDebugFrameDescriptor = $convert.base64Decode(
    'Cg1DYW5EZWJ1Z0ZyYW1lEiEKDHRpbWVzdGFtcF9tcxgBIAEoBFILdGltZXN0YW1wTXMSFQoGYn'
    'VzX2lkGAIgASgNUgVidXNJZBIVCgZjYW5faWQYAyABKA1SBWNhbklkEiQKDmlzX2V4dGVuZGVk'
    'X2lkGAQgASgIUgxpc0V4dGVuZGVkSWQSEgoEZGF0YRgFIAEoDFIEZGF0YQ==');

