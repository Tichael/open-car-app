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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'core.pbenum.dart';
import 'system.pb.dart' as $0;

export 'core.pbenum.dart';

enum AppToDevice_Payload {
  systemCommand, 
  basicCommandBytes, 
  advancedCommandBytes, 
  notSet
}

/// AppToDevice is used for communication from the app to the device in the
/// vehicle. This is mostly for sending commands to the device.
class AppToDevice extends $pb.GeneratedMessage {
  factory AppToDevice({
    $fixnum.Int64? messageId,
    $core.int? platformId,
    $0.SystemCommand? systemCommand,
    $core.List<$core.int>? basicCommandBytes,
    $core.List<$core.int>? advancedCommandBytes,
    $core.List<$core.int>? sourceDeviceId,
  }) {
    final $result = create();
    if (messageId != null) {
      $result.messageId = messageId;
    }
    if (platformId != null) {
      $result.platformId = platformId;
    }
    if (systemCommand != null) {
      $result.systemCommand = systemCommand;
    }
    if (basicCommandBytes != null) {
      $result.basicCommandBytes = basicCommandBytes;
    }
    if (advancedCommandBytes != null) {
      $result.advancedCommandBytes = advancedCommandBytes;
    }
    if (sourceDeviceId != null) {
      $result.sourceDeviceId = sourceDeviceId;
    }
    return $result;
  }
  AppToDevice._() : super();
  factory AppToDevice.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AppToDevice.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, AppToDevice_Payload> _AppToDevice_PayloadByTag = {
    3 : AppToDevice_Payload.systemCommand,
    4 : AppToDevice_Payload.basicCommandBytes,
    5 : AppToDevice_Payload.advancedCommandBytes,
    0 : AppToDevice_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AppToDevice', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.core.v1'), createEmptyInstance: create)
    ..oo(0, [3, 4, 5])
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'messageId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'platformId', $pb.PbFieldType.OU3)
    ..aOM<$0.SystemCommand>(3, _omitFieldNames ? '' : 'systemCommand', subBuilder: $0.SystemCommand.create)
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'basicCommandBytes', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(5, _omitFieldNames ? '' : 'advancedCommandBytes', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(6, _omitFieldNames ? '' : 'sourceDeviceId', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AppToDevice clone() => AppToDevice()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AppToDevice copyWith(void Function(AppToDevice) updates) => super.copyWith((message) => updates(message as AppToDevice)) as AppToDevice;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AppToDevice create() => AppToDevice._();
  AppToDevice createEmptyInstance() => create();
  static $pb.PbList<AppToDevice> createRepeated() => $pb.PbList<AppToDevice>();
  @$core.pragma('dart2js:noInline')
  static AppToDevice getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AppToDevice>(create);
  static AppToDevice? _defaultInstance;

  AppToDevice_Payload whichPayload() => _AppToDevice_PayloadByTag[$_whichOneof(0)]!;
  void clearPayload() => clearField($_whichOneof(0));

  /// A unique identifier for this specific message, which can be used for
  /// request/response matching.
  @$pb.TagNumber(1)
  $fixnum.Int64 get messageId => $_getI64(0);
  @$pb.TagNumber(1)
  set messageId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessageId() => clearField(1);

  /// CRC32 hash of the vehicle platform name. This tells the code how to encode
  /// and decode vehicle specific data.
  @$pb.TagNumber(2)
  $core.int get platformId => $_getIZ(1);
  @$pb.TagNumber(2)
  set platformId($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPlatformId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlatformId() => clearField(2);

  /// A system command. This can only be sent from BLE.
  @$pb.TagNumber(3)
  $0.SystemCommand get systemCommand => $_getN(2);
  @$pb.TagNumber(3)
  set systemCommand($0.SystemCommand v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSystemCommand() => $_has(2);
  @$pb.TagNumber(3)
  void clearSystemCommand() => clearField(3);
  @$pb.TagNumber(3)
  $0.SystemCommand ensureSystemCommand() => $_ensure(2);

  /// A basic command bytes, encoded/decoded using the platform_id. This can be
  /// sent from any communication protocol.
  @$pb.TagNumber(4)
  $core.List<$core.int> get basicCommandBytes => $_getN(3);
  @$pb.TagNumber(4)
  set basicCommandBytes($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBasicCommandBytes() => $_has(3);
  @$pb.TagNumber(4)
  void clearBasicCommandBytes() => clearField(4);

  /// An advanced command bytes, encoded/decoded using the platform_id. This
  /// can only be sent from BLE.
  @$pb.TagNumber(5)
  $core.List<$core.int> get advancedCommandBytes => $_getN(4);
  @$pb.TagNumber(5)
  set advancedCommandBytes($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAdvancedCommandBytes() => $_has(4);
  @$pb.TagNumber(5)
  void clearAdvancedCommandBytes() => clearField(5);

  /// Stable BLE-device identifier for controller arbitration and lifecycle
  /// operations. Required for BLE commands; ignored for MQTT.
  @$pb.TagNumber(6)
  $core.List<$core.int> get sourceDeviceId => $_getN(5);
  @$pb.TagNumber(6)
  set sourceDeviceId($core.List<$core.int> v) { $_setBytes(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSourceDeviceId() => $_has(5);
  @$pb.TagNumber(6)
  void clearSourceDeviceId() => clearField(6);
}

enum DeviceToApp_Payload {
  stateUpdate, 
  commandResponse, 
  canDebugUpdate, 
  notSet
}

/// DeviceToApp is used for communication from the device to the app. This is
/// both for broadcasting the vehicle state and sending response to command sent
/// from the app.
class DeviceToApp extends $pb.GeneratedMessage {
  factory DeviceToApp({
    $fixnum.Int64? timestampMs,
    $core.int? platformId,
    StateUpdate? stateUpdate,
    CommandResponse? commandResponse,
    CanDebugUpdate? canDebugUpdate,
  }) {
    final $result = create();
    if (timestampMs != null) {
      $result.timestampMs = timestampMs;
    }
    if (platformId != null) {
      $result.platformId = platformId;
    }
    if (stateUpdate != null) {
      $result.stateUpdate = stateUpdate;
    }
    if (commandResponse != null) {
      $result.commandResponse = commandResponse;
    }
    if (canDebugUpdate != null) {
      $result.canDebugUpdate = canDebugUpdate;
    }
    return $result;
  }
  DeviceToApp._() : super();
  factory DeviceToApp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeviceToApp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, DeviceToApp_Payload> _DeviceToApp_PayloadByTag = {
    3 : DeviceToApp_Payload.stateUpdate,
    4 : DeviceToApp_Payload.commandResponse,
    5 : DeviceToApp_Payload.canDebugUpdate,
    0 : DeviceToApp_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeviceToApp', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.core.v1'), createEmptyInstance: create)
    ..oo(0, [3, 4, 5])
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'timestampMs', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'platformId', $pb.PbFieldType.OU3)
    ..aOM<StateUpdate>(3, _omitFieldNames ? '' : 'stateUpdate', subBuilder: StateUpdate.create)
    ..aOM<CommandResponse>(4, _omitFieldNames ? '' : 'commandResponse', subBuilder: CommandResponse.create)
    ..aOM<CanDebugUpdate>(5, _omitFieldNames ? '' : 'canDebugUpdate', subBuilder: CanDebugUpdate.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeviceToApp clone() => DeviceToApp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeviceToApp copyWith(void Function(DeviceToApp) updates) => super.copyWith((message) => updates(message as DeviceToApp)) as DeviceToApp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceToApp create() => DeviceToApp._();
  DeviceToApp createEmptyInstance() => create();
  static $pb.PbList<DeviceToApp> createRepeated() => $pb.PbList<DeviceToApp>();
  @$core.pragma('dart2js:noInline')
  static DeviceToApp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeviceToApp>(create);
  static DeviceToApp? _defaultInstance;

  DeviceToApp_Payload whichPayload() => _DeviceToApp_PayloadByTag[$_whichOneof(0)]!;
  void clearPayload() => clearField($_whichOneof(0));

  /// The timestamp when the message was created, as a Unix timestamp in
  /// milliseconds.
  @$pb.TagNumber(1)
  $fixnum.Int64 get timestampMs => $_getI64(0);
  @$pb.TagNumber(1)
  set timestampMs($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimestampMs() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestampMs() => clearField(1);

  /// CRC32 hash of the vehicle platform name. This tells the code how to encode
  /// and decode vehicle specific data.
  @$pb.TagNumber(2)
  $core.int get platformId => $_getIZ(1);
  @$pb.TagNumber(2)
  set platformId($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPlatformId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlatformId() => clearField(2);

  /// A state update. It can contains different kinds of states.
  @$pb.TagNumber(3)
  StateUpdate get stateUpdate => $_getN(2);
  @$pb.TagNumber(3)
  set stateUpdate(StateUpdate v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStateUpdate() => $_has(2);
  @$pb.TagNumber(3)
  void clearStateUpdate() => clearField(3);
  @$pb.TagNumber(3)
  StateUpdate ensureStateUpdate() => $_ensure(2);

  /// A command response. It contains information about the command execution
  /// and potentially response data.
  @$pb.TagNumber(4)
  CommandResponse get commandResponse => $_getN(3);
  @$pb.TagNumber(4)
  set commandResponse(CommandResponse v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCommandResponse() => $_has(3);
  @$pb.TagNumber(4)
  void clearCommandResponse() => clearField(4);
  @$pb.TagNumber(4)
  CommandResponse ensureCommandResponse() => $_ensure(3);

  /// A batch of raw CAN frames for developer debugging. Sent over BLE only,
  /// on the same characteristic as state_update and command_response.
  /// Only produced while CAN debug streaming is active (SetCanDebugEnabled).
  @$pb.TagNumber(5)
  CanDebugUpdate get canDebugUpdate => $_getN(4);
  @$pb.TagNumber(5)
  set canDebugUpdate(CanDebugUpdate v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCanDebugUpdate() => $_has(4);
  @$pb.TagNumber(5)
  void clearCanDebugUpdate() => clearField(5);
  @$pb.TagNumber(5)
  CanDebugUpdate ensureCanDebugUpdate() => $_ensure(4);
}

/// This holds the state update data of the device, containing both the system
/// state and the vehicle specific state.
class StateUpdate extends $pb.GeneratedMessage {
  factory StateUpdate({
    $0.SystemState? systemState,
    VehicleState? vehicleState,
  }) {
    final $result = create();
    if (systemState != null) {
      $result.systemState = systemState;
    }
    if (vehicleState != null) {
      $result.vehicleState = vehicleState;
    }
    return $result;
  }
  StateUpdate._() : super();
  factory StateUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StateUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StateUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.core.v1'), createEmptyInstance: create)
    ..aOM<$0.SystemState>(1, _omitFieldNames ? '' : 'systemState', subBuilder: $0.SystemState.create)
    ..aOM<VehicleState>(2, _omitFieldNames ? '' : 'vehicleState', subBuilder: VehicleState.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StateUpdate clone() => StateUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StateUpdate copyWith(void Function(StateUpdate) updates) => super.copyWith((message) => updates(message as StateUpdate)) as StateUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StateUpdate create() => StateUpdate._();
  StateUpdate createEmptyInstance() => create();
  static $pb.PbList<StateUpdate> createRepeated() => $pb.PbList<StateUpdate>();
  @$core.pragma('dart2js:noInline')
  static StateUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StateUpdate>(create);
  static StateUpdate? _defaultInstance;

  /// System state, only transmitted over BLE.
  @$pb.TagNumber(1)
  $0.SystemState get systemState => $_getN(0);
  @$pb.TagNumber(1)
  set systemState($0.SystemState v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSystemState() => $_has(0);
  @$pb.TagNumber(1)
  void clearSystemState() => clearField(1);
  @$pb.TagNumber(1)
  $0.SystemState ensureSystemState() => $_ensure(0);

  /// Vehicle specific state.
  @$pb.TagNumber(2)
  VehicleState get vehicleState => $_getN(1);
  @$pb.TagNumber(2)
  set vehicleState(VehicleState v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasVehicleState() => $_has(1);
  @$pb.TagNumber(2)
  void clearVehicleState() => clearField(2);
  @$pb.TagNumber(2)
  VehicleState ensureVehicleState() => $_ensure(1);
}

/// This holds the different vehicle specific states.
class VehicleState extends $pb.GeneratedMessage {
  factory VehicleState({
    $core.List<$core.int>? basicStateBytes,
    $core.List<$core.int>? advancedStateBytes,
  }) {
    final $result = create();
    if (basicStateBytes != null) {
      $result.basicStateBytes = basicStateBytes;
    }
    if (advancedStateBytes != null) {
      $result.advancedStateBytes = advancedStateBytes;
    }
    return $result;
  }
  VehicleState._() : super();
  factory VehicleState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VehicleState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VehicleState', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.core.v1'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'basicStateBytes', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'advancedStateBytes', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VehicleState clone() => VehicleState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VehicleState copyWith(void Function(VehicleState) updates) => super.copyWith((message) => updates(message as VehicleState)) as VehicleState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VehicleState create() => VehicleState._();
  VehicleState createEmptyInstance() => create();
  static $pb.PbList<VehicleState> createRepeated() => $pb.PbList<VehicleState>();
  @$core.pragma('dart2js:noInline')
  static VehicleState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VehicleState>(create);
  static VehicleState? _defaultInstance;

  /// The basic vehicle specific state bytes, sent to all connections.
  @$pb.TagNumber(1)
  $core.List<$core.int> get basicStateBytes => $_getN(0);
  @$pb.TagNumber(1)
  set basicStateBytes($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBasicStateBytes() => $_has(0);
  @$pb.TagNumber(1)
  void clearBasicStateBytes() => clearField(1);

  /// The advanced vehicle specific state bytes, sent only over BLE.
  @$pb.TagNumber(2)
  $core.List<$core.int> get advancedStateBytes => $_getN(1);
  @$pb.TagNumber(2)
  set advancedStateBytes($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAdvancedStateBytes() => $_has(1);
  @$pb.TagNumber(2)
  void clearAdvancedStateBytes() => clearField(2);
}

enum CommandResponse_ResponseData {
  basicResponseData, 
  advancedResponseBytes, 
  notSet
}

/// This holds a command response metadata and data.
class CommandResponse extends $pb.GeneratedMessage {
  factory CommandResponse({
    $fixnum.Int64? messageId,
    $core.bool? success,
    $core.String? errorMessage,
    $core.List<$core.int>? basicResponseData,
    $core.List<$core.int>? advancedResponseBytes,
    CommandStatusCode? statusCode,
  }) {
    final $result = create();
    if (messageId != null) {
      $result.messageId = messageId;
    }
    if (success != null) {
      $result.success = success;
    }
    if (errorMessage != null) {
      $result.errorMessage = errorMessage;
    }
    if (basicResponseData != null) {
      $result.basicResponseData = basicResponseData;
    }
    if (advancedResponseBytes != null) {
      $result.advancedResponseBytes = advancedResponseBytes;
    }
    if (statusCode != null) {
      $result.statusCode = statusCode;
    }
    return $result;
  }
  CommandResponse._() : super();
  factory CommandResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CommandResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, CommandResponse_ResponseData> _CommandResponse_ResponseDataByTag = {
    5 : CommandResponse_ResponseData.basicResponseData,
    6 : CommandResponse_ResponseData.advancedResponseBytes,
    0 : CommandResponse_ResponseData.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CommandResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.core.v1'), createEmptyInstance: create)
    ..oo(0, [5, 6])
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'messageId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..a<$core.List<$core.int>>(5, _omitFieldNames ? '' : 'basicResponseData', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(6, _omitFieldNames ? '' : 'advancedResponseBytes', $pb.PbFieldType.OY)
    ..e<CommandStatusCode>(7, _omitFieldNames ? '' : 'statusCode', $pb.PbFieldType.OE, defaultOrMaker: CommandStatusCode.COMMAND_STATUS_CODE_UNSPECIFIED, valueOf: CommandStatusCode.valueOf, enumValues: CommandStatusCode.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CommandResponse clone() => CommandResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CommandResponse copyWith(void Function(CommandResponse) updates) => super.copyWith((message) => updates(message as CommandResponse)) as CommandResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommandResponse create() => CommandResponse._();
  CommandResponse createEmptyInstance() => create();
  static $pb.PbList<CommandResponse> createRepeated() => $pb.PbList<CommandResponse>();
  @$core.pragma('dart2js:noInline')
  static CommandResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CommandResponse>(create);
  static CommandResponse? _defaultInstance;

  CommandResponse_ResponseData whichResponseData() => _CommandResponse_ResponseDataByTag[$_whichOneof(0)]!;
  void clearResponseData() => clearField($_whichOneof(0));

  /// A unique identifier, matching the original request.
  @$pb.TagNumber(1)
  $fixnum.Int64 get messageId => $_getI64(0);
  @$pb.TagNumber(1)
  set messageId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessageId() => clearField(1);

  /// This indicates whether the command succeeded or not.
  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  /// This field contains a human-readable error message when the command failed.
  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  /// Basic response data that can be sent on any communication protocol.
  @$pb.TagNumber(5)
  $core.List<$core.int> get basicResponseData => $_getN(3);
  @$pb.TagNumber(5)
  set basicResponseData($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasBasicResponseData() => $_has(3);
  @$pb.TagNumber(5)
  void clearBasicResponseData() => clearField(5);

  /// Advanced response data that can only be sent over BLE.
  @$pb.TagNumber(6)
  $core.List<$core.int> get advancedResponseBytes => $_getN(4);
  @$pb.TagNumber(6)
  set advancedResponseBytes($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasAdvancedResponseBytes() => $_has(4);
  @$pb.TagNumber(6)
  void clearAdvancedResponseBytes() => clearField(6);

  /// Structured command result code so apps can distinguish policy rejections
  /// (for example, non-controller lease denial) from generic failures.
  @$pb.TagNumber(7)
  CommandStatusCode get statusCode => $_getN(5);
  @$pb.TagNumber(7)
  set statusCode(CommandStatusCode v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatusCode() => $_has(5);
  @$pb.TagNumber(7)
  void clearStatusCode() => clearField(7);
}

/// A batch of raw CAN frames produced by the debug streaming feature.
/// Sent over BLE only, on the same DeviceToApp characteristic as state updates
/// and command responses. Only produced while CAN debug is active.
class CanDebugUpdate extends $pb.GeneratedMessage {
  factory CanDebugUpdate({
    $core.Iterable<CanDebugFrame>? frames,
    $core.int? droppedFrames,
  }) {
    final $result = create();
    if (frames != null) {
      $result.frames.addAll(frames);
    }
    if (droppedFrames != null) {
      $result.droppedFrames = droppedFrames;
    }
    return $result;
  }
  CanDebugUpdate._() : super();
  factory CanDebugUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CanDebugUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CanDebugUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.core.v1'), createEmptyInstance: create)
    ..pc<CanDebugFrame>(1, _omitFieldNames ? '' : 'frames', $pb.PbFieldType.PM, subBuilder: CanDebugFrame.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'droppedFrames', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CanDebugUpdate clone() => CanDebugUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CanDebugUpdate copyWith(void Function(CanDebugUpdate) updates) => super.copyWith((message) => updates(message as CanDebugUpdate)) as CanDebugUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CanDebugUpdate create() => CanDebugUpdate._();
  CanDebugUpdate createEmptyInstance() => create();
  static $pb.PbList<CanDebugUpdate> createRepeated() => $pb.PbList<CanDebugUpdate>();
  @$core.pragma('dart2js:noInline')
  static CanDebugUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CanDebugUpdate>(create);
  static CanDebugUpdate? _defaultInstance;

  /// The captured CAN frames in this batch. May be empty if dropped_frames > 0.
  @$pb.TagNumber(1)
  $core.List<CanDebugFrame> get frames => $_getList(0);

  /// Number of frames dropped since the previous batch because the internal
  /// debug channel was full (i.e. BLE could not keep up with the CAN bus rate).
  /// This counts channel-full failures only — frames excluded by the blocklist
  /// are NOT counted here. Resets to zero after each batch is sent.
  @$pb.TagNumber(2)
  $core.int get droppedFrames => $_getIZ(1);
  @$pb.TagNumber(2)
  set droppedFrames($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDroppedFrames() => $_has(1);
  @$pb.TagNumber(2)
  void clearDroppedFrames() => clearField(2);
}

/// A single raw CAN frame captured for developer debugging.
class CanDebugFrame extends $pb.GeneratedMessage {
  factory CanDebugFrame({
    $fixnum.Int64? timestampMs,
    $core.int? busId,
    $core.int? canId,
    $core.bool? isExtendedId,
    $core.List<$core.int>? data,
  }) {
    final $result = create();
    if (timestampMs != null) {
      $result.timestampMs = timestampMs;
    }
    if (busId != null) {
      $result.busId = busId;
    }
    if (canId != null) {
      $result.canId = canId;
    }
    if (isExtendedId != null) {
      $result.isExtendedId = isExtendedId;
    }
    if (data != null) {
      $result.data = data;
    }
    return $result;
  }
  CanDebugFrame._() : super();
  factory CanDebugFrame.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CanDebugFrame.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CanDebugFrame', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.core.v1'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'timestampMs', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'busId', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'canId', $pb.PbFieldType.OU3)
    ..aOB(4, _omitFieldNames ? '' : 'isExtendedId')
    ..a<$core.List<$core.int>>(5, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CanDebugFrame clone() => CanDebugFrame()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CanDebugFrame copyWith(void Function(CanDebugFrame) updates) => super.copyWith((message) => updates(message as CanDebugFrame)) as CanDebugFrame;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CanDebugFrame create() => CanDebugFrame._();
  CanDebugFrame createEmptyInstance() => create();
  static $pb.PbList<CanDebugFrame> createRepeated() => $pb.PbList<CanDebugFrame>();
  @$core.pragma('dart2js:noInline')
  static CanDebugFrame getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CanDebugFrame>(create);
  static CanDebugFrame? _defaultInstance;

  /// Device uptime in milliseconds at the moment this frame was received from
  /// the CAN bus hardware — set by the board driver, not the batch sender.
  @$pb.TagNumber(1)
  $fixnum.Int64 get timestampMs => $_getI64(0);
  @$pb.TagNumber(1)
  set timestampMs($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimestampMs() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestampMs() => clearField(1);

  /// 0-based index of the CAN bus this frame arrived on, matching the order of
  /// [[can_buses]] entries in the device config.
  @$pb.TagNumber(2)
  $core.int get busId => $_getIZ(1);
  @$pb.TagNumber(2)
  set busId($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBusId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusId() => clearField(2);

  /// The CAN frame identifier (standard 11-bit or extended 29-bit raw value).
  @$pb.TagNumber(3)
  $core.int get canId => $_getIZ(2);
  @$pb.TagNumber(3)
  set canId($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCanId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCanId() => clearField(3);

  /// True if this is an extended (29-bit) frame ID; false for standard (11-bit).
  @$pb.TagNumber(4)
  $core.bool get isExtendedId => $_getBF(3);
  @$pb.TagNumber(4)
  set isExtendedId($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsExtendedId() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsExtendedId() => clearField(4);

  /// Raw frame payload. Contains exactly dlc bytes — NOT zero-padded to 8.
  /// dlc is implicit from the length of this field.
  @$pb.TagNumber(5)
  $core.List<$core.int> get data => $_getN(4);
  @$pb.TagNumber(5)
  set data($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasData() => $_has(4);
  @$pb.TagNumber(5)
  void clearData() => clearField(5);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
