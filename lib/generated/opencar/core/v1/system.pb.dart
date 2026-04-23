//
//  Generated code. Do not modify.
//  source: opencar/core/v1/system.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// This holds the system specific state.
class SystemState extends $pb.GeneratedMessage {
  factory SystemState({
    $core.String? firmwareVersion,
    $core.String? hardwareType,
    $core.int? uptimeS,
    $core.int? lteRssi,
  }) {
    final $result = create();
    if (firmwareVersion != null) {
      $result.firmwareVersion = firmwareVersion;
    }
    if (hardwareType != null) {
      $result.hardwareType = hardwareType;
    }
    if (uptimeS != null) {
      $result.uptimeS = uptimeS;
    }
    if (lteRssi != null) {
      $result.lteRssi = lteRssi;
    }
    return $result;
  }
  SystemState._() : super();
  factory SystemState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SystemState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SystemState', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.core.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'firmwareVersion')
    ..aOS(2, _omitFieldNames ? '' : 'hardwareType')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'uptimeS', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'lteRssi', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SystemState clone() => SystemState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SystemState copyWith(void Function(SystemState) updates) => super.copyWith((message) => updates(message as SystemState)) as SystemState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SystemState create() => SystemState._();
  SystemState createEmptyInstance() => create();
  static $pb.PbList<SystemState> createRepeated() => $pb.PbList<SystemState>();
  @$core.pragma('dart2js:noInline')
  static SystemState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SystemState>(create);
  static SystemState? _defaultInstance;

  /// The current firmware version string, based on the Github official tagged
  /// version or custom build.
  @$pb.TagNumber(1)
  $core.String get firmwareVersion => $_getSZ(0);
  @$pb.TagNumber(1)
  set firmwareVersion($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFirmwareVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirmwareVersion() => clearField(1);

  /// The hardware type of the device (e.g. ESP32-S3)
  @$pb.TagNumber(2)
  $core.String get hardwareType => $_getSZ(1);
  @$pb.TagNumber(2)
  set hardwareType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHardwareType() => $_has(1);
  @$pb.TagNumber(2)
  void clearHardwareType() => clearField(2);

  /// The uptime of the device in seconds.
  @$pb.TagNumber(3)
  $core.int get uptimeS => $_getIZ(2);
  @$pb.TagNumber(3)
  set uptimeS($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUptimeS() => $_has(2);
  @$pb.TagNumber(3)
  void clearUptimeS() => clearField(3);

  /// The LTE signal strength in dBm.
  @$pb.TagNumber(4)
  $core.int get lteRssi => $_getIZ(3);
  @$pb.TagNumber(4)
  set lteRssi($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLteRssi() => $_has(3);
  @$pb.TagNumber(4)
  void clearLteRssi() => clearField(4);
}

enum SystemCommand_Action {
  restartCommand, 
  setCanDebugEnabled, 
  updateCanDebugFilters, 
  listPairedPhones, 
  removePairedPhone, 
  clearPairedPhones, 
  upsertPairedPhone, 
  notSet
}

/// This contains a single system command.
class SystemCommand extends $pb.GeneratedMessage {
  factory SystemCommand({
    RestartCommand? restartCommand,
    SetCanDebugEnabled? setCanDebugEnabled,
    UpdateCanDebugFilters? updateCanDebugFilters,
    ListPairedPhonesCommand? listPairedPhones,
    RemovePairedPhoneCommand? removePairedPhone,
    ClearPairedPhonesCommand? clearPairedPhones,
    UpsertPairedPhoneCommand? upsertPairedPhone,
  }) {
    final $result = create();
    if (restartCommand != null) {
      $result.restartCommand = restartCommand;
    }
    if (setCanDebugEnabled != null) {
      $result.setCanDebugEnabled = setCanDebugEnabled;
    }
    if (updateCanDebugFilters != null) {
      $result.updateCanDebugFilters = updateCanDebugFilters;
    }
    if (listPairedPhones != null) {
      $result.listPairedPhones = listPairedPhones;
    }
    if (removePairedPhone != null) {
      $result.removePairedPhone = removePairedPhone;
    }
    if (clearPairedPhones != null) {
      $result.clearPairedPhones = clearPairedPhones;
    }
    if (upsertPairedPhone != null) {
      $result.upsertPairedPhone = upsertPairedPhone;
    }
    return $result;
  }
  SystemCommand._() : super();
  factory SystemCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SystemCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, SystemCommand_Action> _SystemCommand_ActionByTag = {
    1 : SystemCommand_Action.restartCommand,
    2 : SystemCommand_Action.setCanDebugEnabled,
    3 : SystemCommand_Action.updateCanDebugFilters,
    4 : SystemCommand_Action.listPairedPhones,
    5 : SystemCommand_Action.removePairedPhone,
    6 : SystemCommand_Action.clearPairedPhones,
    7 : SystemCommand_Action.upsertPairedPhone,
    0 : SystemCommand_Action.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SystemCommand', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.core.v1'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7])
    ..aOM<RestartCommand>(1, _omitFieldNames ? '' : 'restartCommand', subBuilder: RestartCommand.create)
    ..aOM<SetCanDebugEnabled>(2, _omitFieldNames ? '' : 'setCanDebugEnabled', subBuilder: SetCanDebugEnabled.create)
    ..aOM<UpdateCanDebugFilters>(3, _omitFieldNames ? '' : 'updateCanDebugFilters', subBuilder: UpdateCanDebugFilters.create)
    ..aOM<ListPairedPhonesCommand>(4, _omitFieldNames ? '' : 'listPairedPhones', subBuilder: ListPairedPhonesCommand.create)
    ..aOM<RemovePairedPhoneCommand>(5, _omitFieldNames ? '' : 'removePairedPhone', subBuilder: RemovePairedPhoneCommand.create)
    ..aOM<ClearPairedPhonesCommand>(6, _omitFieldNames ? '' : 'clearPairedPhones', subBuilder: ClearPairedPhonesCommand.create)
    ..aOM<UpsertPairedPhoneCommand>(7, _omitFieldNames ? '' : 'upsertPairedPhone', subBuilder: UpsertPairedPhoneCommand.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SystemCommand clone() => SystemCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SystemCommand copyWith(void Function(SystemCommand) updates) => super.copyWith((message) => updates(message as SystemCommand)) as SystemCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SystemCommand create() => SystemCommand._();
  SystemCommand createEmptyInstance() => create();
  static $pb.PbList<SystemCommand> createRepeated() => $pb.PbList<SystemCommand>();
  @$core.pragma('dart2js:noInline')
  static SystemCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SystemCommand>(create);
  static SystemCommand? _defaultInstance;

  SystemCommand_Action whichAction() => _SystemCommand_ActionByTag[$_whichOneof(0)]!;
  void clearAction() => clearField($_whichOneof(0));

  /// A restart command.
  @$pb.TagNumber(1)
  RestartCommand get restartCommand => $_getN(0);
  @$pb.TagNumber(1)
  set restartCommand(RestartCommand v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRestartCommand() => $_has(0);
  @$pb.TagNumber(1)
  void clearRestartCommand() => clearField(1);
  @$pb.TagNumber(1)
  RestartCommand ensureRestartCommand() => $_ensure(0);

  /// Enables or disables the on-demand CAN debug streaming mode. BLE only.
  @$pb.TagNumber(2)
  SetCanDebugEnabled get setCanDebugEnabled => $_getN(1);
  @$pb.TagNumber(2)
  set setCanDebugEnabled(SetCanDebugEnabled v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSetCanDebugEnabled() => $_has(1);
  @$pb.TagNumber(2)
  void clearSetCanDebugEnabled() => clearField(2);
  @$pb.TagNumber(2)
  SetCanDebugEnabled ensureSetCanDebugEnabled() => $_ensure(1);

  /// Replaces the active CAN debug blocklist. BLE only.
  @$pb.TagNumber(3)
  UpdateCanDebugFilters get updateCanDebugFilters => $_getN(2);
  @$pb.TagNumber(3)
  set updateCanDebugFilters(UpdateCanDebugFilters v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasUpdateCanDebugFilters() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdateCanDebugFilters() => clearField(3);
  @$pb.TagNumber(3)
  UpdateCanDebugFilters ensureUpdateCanDebugFilters() => $_ensure(2);

  /// Returns the currently bonded BLE phones.
  @$pb.TagNumber(4)
  ListPairedPhonesCommand get listPairedPhones => $_getN(3);
  @$pb.TagNumber(4)
  set listPairedPhones(ListPairedPhonesCommand v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasListPairedPhones() => $_has(3);
  @$pb.TagNumber(4)
  void clearListPairedPhones() => clearField(4);
  @$pb.TagNumber(4)
  ListPairedPhonesCommand ensureListPairedPhones() => $_ensure(3);

  /// Removes one bonded BLE phone by its stable device ID.
  @$pb.TagNumber(5)
  RemovePairedPhoneCommand get removePairedPhone => $_getN(4);
  @$pb.TagNumber(5)
  set removePairedPhone(RemovePairedPhoneCommand v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasRemovePairedPhone() => $_has(4);
  @$pb.TagNumber(5)
  void clearRemovePairedPhone() => clearField(5);
  @$pb.TagNumber(5)
  RemovePairedPhoneCommand ensureRemovePairedPhone() => $_ensure(4);

  /// Removes all bonded BLE phones.
  @$pb.TagNumber(6)
  ClearPairedPhonesCommand get clearPairedPhones => $_getN(5);
  @$pb.TagNumber(6)
  set clearPairedPhones(ClearPairedPhonesCommand v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasClearPairedPhones() => $_has(5);
  @$pb.TagNumber(6)
  void clearClearPairedPhones() => clearField(6);
  @$pb.TagNumber(6)
  ClearPairedPhonesCommand ensureClearPairedPhones() => $_ensure(5);

  /// Records a newly paired BLE phone in the bonded registry.
  @$pb.TagNumber(7)
  UpsertPairedPhoneCommand get upsertPairedPhone => $_getN(6);
  @$pb.TagNumber(7)
  set upsertPairedPhone(UpsertPairedPhoneCommand v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasUpsertPairedPhone() => $_has(6);
  @$pb.TagNumber(7)
  void clearUpsertPairedPhone() => clearField(7);
  @$pb.TagNumber(7)
  UpsertPairedPhoneCommand ensureUpsertPairedPhone() => $_ensure(6);
}

/// This command tells the system to restart.
class RestartCommand extends $pb.GeneratedMessage {
  factory RestartCommand() => create();
  RestartCommand._() : super();
  factory RestartCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RestartCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RestartCommand', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.core.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RestartCommand clone() => RestartCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RestartCommand copyWith(void Function(RestartCommand) updates) => super.copyWith((message) => updates(message as RestartCommand)) as RestartCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RestartCommand create() => RestartCommand._();
  RestartCommand createEmptyInstance() => create();
  static $pb.PbList<RestartCommand> createRepeated() => $pb.PbList<RestartCommand>();
  @$core.pragma('dart2js:noInline')
  static RestartCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RestartCommand>(create);
  static RestartCommand? _defaultInstance;
}

///  Enables or disables on-demand CAN debug streaming over BLE.
///
///  When enabled, raw CAN frames (before vehicle-specific filtering) are batched
///  and sent to the app as CanDebugUpdate messages on the existing DeviceToApp
///  BLE characteristic. No new characteristic or subscription is required.
///
///  This command is sent via the existing AppToDevice BLE characteristic.
class SetCanDebugEnabled extends $pb.GeneratedMessage {
  factory SetCanDebugEnabled({
    $core.bool? enabled,
    $core.Iterable<$core.int>? busIds,
  }) {
    final $result = create();
    if (enabled != null) {
      $result.enabled = enabled;
    }
    if (busIds != null) {
      $result.busIds.addAll(busIds);
    }
    return $result;
  }
  SetCanDebugEnabled._() : super();
  factory SetCanDebugEnabled.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetCanDebugEnabled.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetCanDebugEnabled', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.core.v1'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'enabled')
    ..p<$core.int>(2, _omitFieldNames ? '' : 'busIds', $pb.PbFieldType.KU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetCanDebugEnabled clone() => SetCanDebugEnabled()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetCanDebugEnabled copyWith(void Function(SetCanDebugEnabled) updates) => super.copyWith((message) => updates(message as SetCanDebugEnabled)) as SetCanDebugEnabled;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetCanDebugEnabled create() => SetCanDebugEnabled._();
  SetCanDebugEnabled createEmptyInstance() => create();
  static $pb.PbList<SetCanDebugEnabled> createRepeated() => $pb.PbList<SetCanDebugEnabled>();
  @$core.pragma('dart2js:noInline')
  static SetCanDebugEnabled getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetCanDebugEnabled>(create);
  static SetCanDebugEnabled? _defaultInstance;

  /// Whether to enable (true) or disable (false) CAN debug streaming.
  @$pb.TagNumber(1)
  $core.bool get enabled => $_getBF(0);
  @$pb.TagNumber(1)
  set enabled($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEnabled() => $_has(0);
  @$pb.TagNumber(1)
  void clearEnabled() => clearField(1);

  /// The CAN bus IDs to stream. Each value is a 0-based bus index matching the
  /// order of [[can_buses]] entries in the device config. An empty list means
  /// all buses are observed.
  @$pb.TagNumber(2)
  $core.List<$core.int> get busIds => $_getList(1);
}

///  Replaces the full CAN debug blocklist. Silently ignored if CAN debug is
///  not currently active.
///
///  The app owns the filter state; this message always sends the complete desired
///  list. The firmware replaces its stored list atomically on receipt. To clear
///  all filters (pass everything), send an empty list.
class UpdateCanDebugFilters extends $pb.GeneratedMessage {
  factory UpdateCanDebugFilters({
    $core.Iterable<CanDebugFilter>? filters,
  }) {
    final $result = create();
    if (filters != null) {
      $result.filters.addAll(filters);
    }
    return $result;
  }
  UpdateCanDebugFilters._() : super();
  factory UpdateCanDebugFilters.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateCanDebugFilters.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateCanDebugFilters', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.core.v1'), createEmptyInstance: create)
    ..pc<CanDebugFilter>(1, _omitFieldNames ? '' : 'filters', $pb.PbFieldType.PM, subBuilder: CanDebugFilter.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateCanDebugFilters clone() => UpdateCanDebugFilters()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateCanDebugFilters copyWith(void Function(UpdateCanDebugFilters) updates) => super.copyWith((message) => updates(message as UpdateCanDebugFilters)) as UpdateCanDebugFilters;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateCanDebugFilters create() => UpdateCanDebugFilters._();
  UpdateCanDebugFilters createEmptyInstance() => create();
  static $pb.PbList<UpdateCanDebugFilters> createRepeated() => $pb.PbList<UpdateCanDebugFilters>();
  @$core.pragma('dart2js:noInline')
  static UpdateCanDebugFilters getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateCanDebugFilters>(create);
  static UpdateCanDebugFilters? _defaultInstance;

  /// The new blocklist. Any frame matching any entry is excluded from the
  /// CanDebugUpdate stream. An empty list means all frames are forwarded.
  @$pb.TagNumber(1)
  $core.List<CanDebugFilter> get filters => $_getList(0);
}

///  A single CAN debug blocklist entry. A frame is excluded from the debug stream
///  if: (frame_can_id & mask) == (can_id & mask) AND is_extended_id matches.
///
///  The blocklist applies across all buses being observed; there is no per-bus
///  filter scoping.
class CanDebugFilter extends $pb.GeneratedMessage {
  factory CanDebugFilter({
    $core.int? canId,
    $core.bool? isExtendedId,
    $core.int? mask,
  }) {
    final $result = create();
    if (canId != null) {
      $result.canId = canId;
    }
    if (isExtendedId != null) {
      $result.isExtendedId = isExtendedId;
    }
    if (mask != null) {
      $result.mask = mask;
    }
    return $result;
  }
  CanDebugFilter._() : super();
  factory CanDebugFilter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CanDebugFilter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CanDebugFilter', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.core.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'canId', $pb.PbFieldType.OU3)
    ..aOB(2, _omitFieldNames ? '' : 'isExtendedId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'mask', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CanDebugFilter clone() => CanDebugFilter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CanDebugFilter copyWith(void Function(CanDebugFilter) updates) => super.copyWith((message) => updates(message as CanDebugFilter)) as CanDebugFilter;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CanDebugFilter create() => CanDebugFilter._();
  CanDebugFilter createEmptyInstance() => create();
  static $pb.PbList<CanDebugFilter> createRepeated() => $pb.PbList<CanDebugFilter>();
  @$core.pragma('dart2js:noInline')
  static CanDebugFilter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CanDebugFilter>(create);
  static CanDebugFilter? _defaultInstance;

  /// The CAN identifier to match against.
  @$pb.TagNumber(1)
  $core.int get canId => $_getIZ(0);
  @$pb.TagNumber(1)
  set canId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCanId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCanId() => clearField(1);

  /// True if this filter targets extended (29-bit) frame IDs; false for
  /// standard (11-bit) frame IDs.
  @$pb.TagNumber(2)
  $core.bool get isExtendedId => $_getBF(1);
  @$pb.TagNumber(2)
  set isExtendedId($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsExtendedId() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsExtendedId() => clearField(2);

  /// Acceptance mask. Bits set to 1 must match between the frame ID and
  /// can_id. Use 0x7FF for exact standard-ID match, 0x1FFFFFFF for exact
  /// extended-ID match, or 0 to block every frame regardless of ID.
  @$pb.TagNumber(3)
  $core.int get mask => $_getIZ(2);
  @$pb.TagNumber(3)
  set mask($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMask() => $_has(2);
  @$pb.TagNumber(3)
  void clearMask() => clearField(3);
}

/// Requests the list of currently bonded BLE phones.
class ListPairedPhonesCommand extends $pb.GeneratedMessage {
  factory ListPairedPhonesCommand() => create();
  ListPairedPhonesCommand._() : super();
  factory ListPairedPhonesCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPairedPhonesCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListPairedPhonesCommand', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.core.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPairedPhonesCommand clone() => ListPairedPhonesCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPairedPhonesCommand copyWith(void Function(ListPairedPhonesCommand) updates) => super.copyWith((message) => updates(message as ListPairedPhonesCommand)) as ListPairedPhonesCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPairedPhonesCommand create() => ListPairedPhonesCommand._();
  ListPairedPhonesCommand createEmptyInstance() => create();
  static $pb.PbList<ListPairedPhonesCommand> createRepeated() => $pb.PbList<ListPairedPhonesCommand>();
  @$core.pragma('dart2js:noInline')
  static ListPairedPhonesCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListPairedPhonesCommand>(create);
  static ListPairedPhonesCommand? _defaultInstance;
}

/// Requests removal of a single bonded BLE phone.
class RemovePairedPhoneCommand extends $pb.GeneratedMessage {
  factory RemovePairedPhoneCommand({
    $core.List<$core.int>? deviceId,
  }) {
    final $result = create();
    if (deviceId != null) {
      $result.deviceId = deviceId;
    }
    return $result;
  }
  RemovePairedPhoneCommand._() : super();
  factory RemovePairedPhoneCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemovePairedPhoneCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemovePairedPhoneCommand', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.core.v1'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'deviceId', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemovePairedPhoneCommand clone() => RemovePairedPhoneCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemovePairedPhoneCommand copyWith(void Function(RemovePairedPhoneCommand) updates) => super.copyWith((message) => updates(message as RemovePairedPhoneCommand)) as RemovePairedPhoneCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemovePairedPhoneCommand create() => RemovePairedPhoneCommand._();
  RemovePairedPhoneCommand createEmptyInstance() => create();
  static $pb.PbList<RemovePairedPhoneCommand> createRepeated() => $pb.PbList<RemovePairedPhoneCommand>();
  @$core.pragma('dart2js:noInline')
  static RemovePairedPhoneCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemovePairedPhoneCommand>(create);
  static RemovePairedPhoneCommand? _defaultInstance;

  /// Stable firmware-owned identifier for the bonded phone.
  @$pb.TagNumber(1)
  $core.List<$core.int> get deviceId => $_getN(0);
  @$pb.TagNumber(1)
  set deviceId($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDeviceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceId() => clearField(1);
}

/// Requests removal of all bonded BLE phones.
class ClearPairedPhonesCommand extends $pb.GeneratedMessage {
  factory ClearPairedPhonesCommand() => create();
  ClearPairedPhonesCommand._() : super();
  factory ClearPairedPhonesCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClearPairedPhonesCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClearPairedPhonesCommand', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.core.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClearPairedPhonesCommand clone() => ClearPairedPhonesCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClearPairedPhonesCommand copyWith(void Function(ClearPairedPhonesCommand) updates) => super.copyWith((message) => updates(message as ClearPairedPhonesCommand)) as ClearPairedPhonesCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClearPairedPhonesCommand create() => ClearPairedPhonesCommand._();
  ClearPairedPhonesCommand createEmptyInstance() => create();
  static $pb.PbList<ClearPairedPhonesCommand> createRepeated() => $pb.PbList<ClearPairedPhonesCommand>();
  @$core.pragma('dart2js:noInline')
  static ClearPairedPhonesCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClearPairedPhonesCommand>(create);
  static ClearPairedPhonesCommand? _defaultInstance;
}

/// Adds a bonded BLE phone if it is not already present.
class UpsertPairedPhoneCommand extends $pb.GeneratedMessage {
  factory UpsertPairedPhoneCommand({
    $core.List<$core.int>? deviceId,
  }) {
    final $result = create();
    if (deviceId != null) {
      $result.deviceId = deviceId;
    }
    return $result;
  }
  UpsertPairedPhoneCommand._() : super();
  factory UpsertPairedPhoneCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpsertPairedPhoneCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpsertPairedPhoneCommand', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.core.v1'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'deviceId', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpsertPairedPhoneCommand clone() => UpsertPairedPhoneCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpsertPairedPhoneCommand copyWith(void Function(UpsertPairedPhoneCommand) updates) => super.copyWith((message) => updates(message as UpsertPairedPhoneCommand)) as UpsertPairedPhoneCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpsertPairedPhoneCommand create() => UpsertPairedPhoneCommand._();
  UpsertPairedPhoneCommand createEmptyInstance() => create();
  static $pb.PbList<UpsertPairedPhoneCommand> createRepeated() => $pb.PbList<UpsertPairedPhoneCommand>();
  @$core.pragma('dart2js:noInline')
  static UpsertPairedPhoneCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpsertPairedPhoneCommand>(create);
  static UpsertPairedPhoneCommand? _defaultInstance;

  /// Stable firmware-owned identifier for the bonded phone.
  @$pb.TagNumber(1)
  $core.List<$core.int> get deviceId => $_getN(0);
  @$pb.TagNumber(1)
  set deviceId($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDeviceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceId() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
