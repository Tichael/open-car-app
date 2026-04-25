//
//  Generated code. Do not modify.
//  source: opencar/cars/virtual_car/v1/virtual_car.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use basicStateDescriptor instead')
const BasicState$json = {
  '1': 'BasicState',
  '2': [
    {'1': 'odometer', '3': 1, '4': 1, '5': 13, '9': 0, '10': 'odometer', '17': true},
    {'1': 'is_driving', '3': 2, '4': 1, '5': 8, '9': 1, '10': 'isDriving', '17': true},
    {'1': 'are_doors_locked', '3': 3, '4': 1, '5': 8, '9': 2, '10': 'areDoorsLocked', '17': true},
  ],
  '8': [
    {'1': '_odometer'},
    {'1': '_is_driving'},
    {'1': '_are_doors_locked'},
  ],
};

/// Descriptor for `BasicState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List basicStateDescriptor = $convert.base64Decode(
    'CgpCYXNpY1N0YXRlEh8KCG9kb21ldGVyGAEgASgNSABSCG9kb21ldGVyiAEBEiIKCmlzX2RyaX'
    'ZpbmcYAiABKAhIAVIJaXNEcml2aW5niAEBEi0KEGFyZV9kb29yc19sb2NrZWQYAyABKAhIAlIO'
    'YXJlRG9vcnNMb2NrZWSIAQFCCwoJX29kb21ldGVyQg0KC19pc19kcml2aW5nQhMKEV9hcmVfZG'
    '9vcnNfbG9ja2Vk');

@$core.Deprecated('Use advancedStateDescriptor instead')
const AdvancedState$json = {
  '1': 'AdvancedState',
  '2': [
    {'1': 'speed', '3': 1, '4': 1, '5': 5, '9': 0, '10': 'speed', '17': true},
    {'1': 'gear', '3': 2, '4': 1, '5': 14, '6': '.opencar.cars.virtual_car.v1.AdvancedState.Gear', '9': 1, '10': 'gear', '17': true},
    {'1': 'custom_state1', '3': 3, '4': 1, '5': 8, '9': 2, '10': 'customState1', '17': true},
  ],
  '4': [AdvancedState_Gear$json],
  '8': [
    {'1': '_speed'},
    {'1': '_gear'},
    {'1': '_custom_state1'},
  ],
};

@$core.Deprecated('Use advancedStateDescriptor instead')
const AdvancedState_Gear$json = {
  '1': 'Gear',
  '2': [
    {'1': 'GEAR_UNSPECIFIED', '2': 0},
    {'1': 'GEAR_PARK', '2': 1},
    {'1': 'GEAR_REVERSE', '2': 2},
    {'1': 'GEAR_NEUTRAL', '2': 3},
    {'1': 'GEAR_DRIVE', '2': 4},
  ],
};

/// Descriptor for `AdvancedState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List advancedStateDescriptor = $convert.base64Decode(
    'Cg1BZHZhbmNlZFN0YXRlEhkKBXNwZWVkGAEgASgFSABSBXNwZWVkiAEBEkgKBGdlYXIYAiABKA'
    '4yLy5vcGVuY2FyLmNhcnMudmlydHVhbF9jYXIudjEuQWR2YW5jZWRTdGF0ZS5HZWFySAFSBGdl'
    'YXKIAQESKAoNY3VzdG9tX3N0YXRlMRgDIAEoCEgCUgxjdXN0b21TdGF0ZTGIAQEiXwoER2Vhch'
    'IUChBHRUFSX1VOU1BFQ0lGSUVEEAASDQoJR0VBUl9QQVJLEAESEAoMR0VBUl9SRVZFUlNFEAIS'
    'EAoMR0VBUl9ORVVUUkFMEAMSDgoKR0VBUl9EUklWRRAEQggKBl9zcGVlZEIHCgVfZ2VhckIQCg'
    '5fY3VzdG9tX3N0YXRlMQ==');

@$core.Deprecated('Use basicCommandDescriptor instead')
const BasicCommand$json = {
  '1': 'BasicCommand',
  '2': [
    {'1': 'door_lock', '3': 1, '4': 1, '5': 11, '6': '.opencar.cars.virtual_car.v1.DoorLockCommand', '9': 0, '10': 'doorLock'},
  ],
  '8': [
    {'1': 'action'},
  ],
};

/// Descriptor for `BasicCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List basicCommandDescriptor = $convert.base64Decode(
    'CgxCYXNpY0NvbW1hbmQSSwoJZG9vcl9sb2NrGAEgASgLMiwub3BlbmNhci5jYXJzLnZpcnR1YW'
    'xfY2FyLnYxLkRvb3JMb2NrQ29tbWFuZEgAUghkb29yTG9ja0IICgZhY3Rpb24=');

@$core.Deprecated('Use advancedCommandDescriptor instead')
const AdvancedCommand$json = {
  '1': 'AdvancedCommand',
  '2': [
    {'1': 'toggle_custom_state1', '3': 1, '4': 1, '5': 11, '6': '.opencar.cars.virtual_car.v1.ToggleCustomState1Command', '9': 0, '10': 'toggleCustomState1'},
  ],
  '8': [
    {'1': 'action'},
  ],
};

/// Descriptor for `AdvancedCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List advancedCommandDescriptor = $convert.base64Decode(
    'Cg9BZHZhbmNlZENvbW1hbmQSagoUdG9nZ2xlX2N1c3RvbV9zdGF0ZTEYASABKAsyNi5vcGVuY2'
    'FyLmNhcnMudmlydHVhbF9jYXIudjEuVG9nZ2xlQ3VzdG9tU3RhdGUxQ29tbWFuZEgAUhJ0b2dn'
    'bGVDdXN0b21TdGF0ZTFCCAoGYWN0aW9u');

@$core.Deprecated('Use doorLockCommandDescriptor instead')
const DoorLockCommand$json = {
  '1': 'DoorLockCommand',
  '2': [
    {'1': 'lock', '3': 1, '4': 1, '5': 8, '10': 'lock'},
  ],
};

/// Descriptor for `DoorLockCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List doorLockCommandDescriptor = $convert.base64Decode(
    'Cg9Eb29yTG9ja0NvbW1hbmQSEgoEbG9jaxgBIAEoCFIEbG9jaw==');

@$core.Deprecated('Use toggleCustomState1CommandDescriptor instead')
const ToggleCustomState1Command$json = {
  '1': 'ToggleCustomState1Command',
};

/// Descriptor for `ToggleCustomState1Command`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleCustomState1CommandDescriptor = $convert.base64Decode(
    'ChlUb2dnbGVDdXN0b21TdGF0ZTFDb21tYW5k');

