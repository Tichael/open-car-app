//
//  Generated code. Do not modify.
//  source: opencar/core/v1/system.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use systemStateDescriptor instead')
const SystemState$json = {
  '1': 'SystemState',
  '2': [
    {'1': 'firmware_version', '3': 1, '4': 1, '5': 9, '10': 'firmwareVersion'},
    {'1': 'hardware_type', '3': 2, '4': 1, '5': 9, '10': 'hardwareType'},
    {'1': 'uptime_s', '3': 3, '4': 1, '5': 13, '10': 'uptimeS'},
    {'1': 'lte_rssi', '3': 4, '4': 1, '5': 5, '10': 'lteRssi'},
  ],
};

/// Descriptor for `SystemState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List systemStateDescriptor = $convert.base64Decode(
    'CgtTeXN0ZW1TdGF0ZRIpChBmaXJtd2FyZV92ZXJzaW9uGAEgASgJUg9maXJtd2FyZVZlcnNpb2'
    '4SIwoNaGFyZHdhcmVfdHlwZRgCIAEoCVIMaGFyZHdhcmVUeXBlEhkKCHVwdGltZV9zGAMgASgN'
    'Ugd1cHRpbWVTEhkKCGx0ZV9yc3NpGAQgASgFUgdsdGVSc3Np');

@$core.Deprecated('Use systemCommandDescriptor instead')
const SystemCommand$json = {
  '1': 'SystemCommand',
  '2': [
    {'1': 'restart_command', '3': 1, '4': 1, '5': 11, '6': '.opencar.core.v1.RestartCommand', '9': 0, '10': 'restartCommand'},
    {'1': 'set_can_debug_enabled', '3': 2, '4': 1, '5': 11, '6': '.opencar.core.v1.SetCanDebugEnabled', '9': 0, '10': 'setCanDebugEnabled'},
    {'1': 'update_can_debug_filters', '3': 3, '4': 1, '5': 11, '6': '.opencar.core.v1.UpdateCanDebugFilters', '9': 0, '10': 'updateCanDebugFilters'},
    {'1': 'list_paired_phones', '3': 4, '4': 1, '5': 11, '6': '.opencar.core.v1.ListPairedPhonesCommand', '9': 0, '10': 'listPairedPhones'},
    {'1': 'remove_paired_phone', '3': 5, '4': 1, '5': 11, '6': '.opencar.core.v1.RemovePairedPhoneCommand', '9': 0, '10': 'removePairedPhone'},
    {'1': 'clear_paired_phones', '3': 6, '4': 1, '5': 11, '6': '.opencar.core.v1.ClearPairedPhonesCommand', '9': 0, '10': 'clearPairedPhones'},
    {'1': 'upsert_paired_phone', '3': 7, '4': 1, '5': 11, '6': '.opencar.core.v1.UpsertPairedPhoneCommand', '9': 0, '10': 'upsertPairedPhone'},
  ],
  '8': [
    {'1': 'action'},
  ],
};

/// Descriptor for `SystemCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List systemCommandDescriptor = $convert.base64Decode(
    'Cg1TeXN0ZW1Db21tYW5kEkoKD3Jlc3RhcnRfY29tbWFuZBgBIAEoCzIfLm9wZW5jYXIuY29yZS'
    '52MS5SZXN0YXJ0Q29tbWFuZEgAUg5yZXN0YXJ0Q29tbWFuZBJYChVzZXRfY2FuX2RlYnVnX2Vu'
    'YWJsZWQYAiABKAsyIy5vcGVuY2FyLmNvcmUudjEuU2V0Q2FuRGVidWdFbmFibGVkSABSEnNldE'
    'NhbkRlYnVnRW5hYmxlZBJhChh1cGRhdGVfY2FuX2RlYnVnX2ZpbHRlcnMYAyABKAsyJi5vcGVu'
    'Y2FyLmNvcmUudjEuVXBkYXRlQ2FuRGVidWdGaWx0ZXJzSABSFXVwZGF0ZUNhbkRlYnVnRmlsdG'
    'VycxJYChJsaXN0X3BhaXJlZF9waG9uZXMYBCABKAsyKC5vcGVuY2FyLmNvcmUudjEuTGlzdFBh'
    'aXJlZFBob25lc0NvbW1hbmRIAFIQbGlzdFBhaXJlZFBob25lcxJbChNyZW1vdmVfcGFpcmVkX3'
    'Bob25lGAUgASgLMikub3BlbmNhci5jb3JlLnYxLlJlbW92ZVBhaXJlZFBob25lQ29tbWFuZEgA'
    'UhFyZW1vdmVQYWlyZWRQaG9uZRJbChNjbGVhcl9wYWlyZWRfcGhvbmVzGAYgASgLMikub3Blbm'
    'Nhci5jb3JlLnYxLkNsZWFyUGFpcmVkUGhvbmVzQ29tbWFuZEgAUhFjbGVhclBhaXJlZFBob25l'
    'cxJbChN1cHNlcnRfcGFpcmVkX3Bob25lGAcgASgLMikub3BlbmNhci5jb3JlLnYxLlVwc2VydF'
    'BhaXJlZFBob25lQ29tbWFuZEgAUhF1cHNlcnRQYWlyZWRQaG9uZUIICgZhY3Rpb24=');

@$core.Deprecated('Use restartCommandDescriptor instead')
const RestartCommand$json = {
  '1': 'RestartCommand',
};

/// Descriptor for `RestartCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List restartCommandDescriptor = $convert.base64Decode(
    'Cg5SZXN0YXJ0Q29tbWFuZA==');

@$core.Deprecated('Use setCanDebugEnabledDescriptor instead')
const SetCanDebugEnabled$json = {
  '1': 'SetCanDebugEnabled',
  '2': [
    {'1': 'enabled', '3': 1, '4': 1, '5': 8, '10': 'enabled'},
    {'1': 'bus_ids', '3': 2, '4': 3, '5': 13, '10': 'busIds'},
  ],
};

/// Descriptor for `SetCanDebugEnabled`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setCanDebugEnabledDescriptor = $convert.base64Decode(
    'ChJTZXRDYW5EZWJ1Z0VuYWJsZWQSGAoHZW5hYmxlZBgBIAEoCFIHZW5hYmxlZBIXCgdidXNfaW'
    'RzGAIgAygNUgZidXNJZHM=');

@$core.Deprecated('Use updateCanDebugFiltersDescriptor instead')
const UpdateCanDebugFilters$json = {
  '1': 'UpdateCanDebugFilters',
  '2': [
    {'1': 'filters', '3': 1, '4': 3, '5': 11, '6': '.opencar.core.v1.CanDebugFilter', '10': 'filters'},
  ],
};

/// Descriptor for `UpdateCanDebugFilters`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCanDebugFiltersDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVDYW5EZWJ1Z0ZpbHRlcnMSOQoHZmlsdGVycxgBIAMoCzIfLm9wZW5jYXIuY29yZS'
    '52MS5DYW5EZWJ1Z0ZpbHRlclIHZmlsdGVycw==');

@$core.Deprecated('Use canDebugFilterDescriptor instead')
const CanDebugFilter$json = {
  '1': 'CanDebugFilter',
  '2': [
    {'1': 'can_id', '3': 1, '4': 1, '5': 13, '10': 'canId'},
    {'1': 'is_extended_id', '3': 2, '4': 1, '5': 8, '10': 'isExtendedId'},
    {'1': 'mask', '3': 3, '4': 1, '5': 13, '10': 'mask'},
  ],
};

/// Descriptor for `CanDebugFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List canDebugFilterDescriptor = $convert.base64Decode(
    'Cg5DYW5EZWJ1Z0ZpbHRlchIVCgZjYW5faWQYASABKA1SBWNhbklkEiQKDmlzX2V4dGVuZGVkX2'
    'lkGAIgASgIUgxpc0V4dGVuZGVkSWQSEgoEbWFzaxgDIAEoDVIEbWFzaw==');

@$core.Deprecated('Use listPairedPhonesCommandDescriptor instead')
const ListPairedPhonesCommand$json = {
  '1': 'ListPairedPhonesCommand',
};

/// Descriptor for `ListPairedPhonesCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPairedPhonesCommandDescriptor = $convert.base64Decode(
    'ChdMaXN0UGFpcmVkUGhvbmVzQ29tbWFuZA==');

@$core.Deprecated('Use removePairedPhoneCommandDescriptor instead')
const RemovePairedPhoneCommand$json = {
  '1': 'RemovePairedPhoneCommand',
  '2': [
    {'1': 'device_id', '3': 1, '4': 1, '5': 12, '10': 'deviceId'},
  ],
};

/// Descriptor for `RemovePairedPhoneCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removePairedPhoneCommandDescriptor = $convert.base64Decode(
    'ChhSZW1vdmVQYWlyZWRQaG9uZUNvbW1hbmQSGwoJZGV2aWNlX2lkGAEgASgMUghkZXZpY2VJZA'
    '==');

@$core.Deprecated('Use clearPairedPhonesCommandDescriptor instead')
const ClearPairedPhonesCommand$json = {
  '1': 'ClearPairedPhonesCommand',
};

/// Descriptor for `ClearPairedPhonesCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clearPairedPhonesCommandDescriptor = $convert.base64Decode(
    'ChhDbGVhclBhaXJlZFBob25lc0NvbW1hbmQ=');

@$core.Deprecated('Use upsertPairedPhoneCommandDescriptor instead')
const UpsertPairedPhoneCommand$json = {
  '1': 'UpsertPairedPhoneCommand',
  '2': [
    {'1': 'device_id', '3': 1, '4': 1, '5': 12, '10': 'deviceId'},
  ],
};

/// Descriptor for `UpsertPairedPhoneCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upsertPairedPhoneCommandDescriptor = $convert.base64Decode(
    'ChhVcHNlcnRQYWlyZWRQaG9uZUNvbW1hbmQSGwoJZGV2aWNlX2lkGAEgASgMUghkZXZpY2VJZA'
    '==');

