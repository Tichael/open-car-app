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

import 'virtual_car.pbenum.dart';

export 'virtual_car.pbenum.dart';

/// Basic state that can be broadcasted on any communication protocol.
class BasicState extends $pb.GeneratedMessage {
  factory BasicState({
    $core.int? odometer,
    $core.bool? isDriving,
    $core.bool? areDoorsLocked,
  }) {
    final $result = create();
    if (odometer != null) {
      $result.odometer = odometer;
    }
    if (isDriving != null) {
      $result.isDriving = isDriving;
    }
    if (areDoorsLocked != null) {
      $result.areDoorsLocked = areDoorsLocked;
    }
    return $result;
  }
  BasicState._() : super();
  factory BasicState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BasicState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BasicState', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.cars.virtual_car.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'odometer', $pb.PbFieldType.OU3)
    ..aOB(2, _omitFieldNames ? '' : 'isDriving')
    ..aOB(3, _omitFieldNames ? '' : 'areDoorsLocked')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BasicState clone() => BasicState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BasicState copyWith(void Function(BasicState) updates) => super.copyWith((message) => updates(message as BasicState)) as BasicState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BasicState create() => BasicState._();
  BasicState createEmptyInstance() => create();
  static $pb.PbList<BasicState> createRepeated() => $pb.PbList<BasicState>();
  @$core.pragma('dart2js:noInline')
  static BasicState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BasicState>(create);
  static BasicState? _defaultInstance;

  /// The odometer value of the car, in kilometers.
  @$pb.TagNumber(1)
  $core.int get odometer => $_getIZ(0);
  @$pb.TagNumber(1)
  set odometer($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOdometer() => $_has(0);
  @$pb.TagNumber(1)
  void clearOdometer() => clearField(1);

  /// Simple state indicating if the car is driving or not.
  @$pb.TagNumber(2)
  $core.bool get isDriving => $_getBF(1);
  @$pb.TagNumber(2)
  set isDriving($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsDriving() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsDriving() => clearField(2);

  /// Simple state indicating if the car's doors are locked or not.
  @$pb.TagNumber(3)
  $core.bool get areDoorsLocked => $_getBF(2);
  @$pb.TagNumber(3)
  set areDoorsLocked($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAreDoorsLocked() => $_has(2);
  @$pb.TagNumber(3)
  void clearAreDoorsLocked() => clearField(3);
}

/// Advanced state that can only be shared over BLE.
class AdvancedState extends $pb.GeneratedMessage {
  factory AdvancedState({
    $core.int? speed,
    AdvancedState_Gear? gear,
  }) {
    final $result = create();
    if (speed != null) {
      $result.speed = speed;
    }
    if (gear != null) {
      $result.gear = gear;
    }
    return $result;
  }
  AdvancedState._() : super();
  factory AdvancedState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdvancedState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdvancedState', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.cars.virtual_car.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'speed', $pb.PbFieldType.O3)
    ..e<AdvancedState_Gear>(2, _omitFieldNames ? '' : 'gear', $pb.PbFieldType.OE, defaultOrMaker: AdvancedState_Gear.GEAR_UNSPECIFIED, valueOf: AdvancedState_Gear.valueOf, enumValues: AdvancedState_Gear.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdvancedState clone() => AdvancedState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdvancedState copyWith(void Function(AdvancedState) updates) => super.copyWith((message) => updates(message as AdvancedState)) as AdvancedState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdvancedState create() => AdvancedState._();
  AdvancedState createEmptyInstance() => create();
  static $pb.PbList<AdvancedState> createRepeated() => $pb.PbList<AdvancedState>();
  @$core.pragma('dart2js:noInline')
  static AdvancedState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdvancedState>(create);
  static AdvancedState? _defaultInstance;

  /// The current car speed, in kph.
  @$pb.TagNumber(1)
  $core.int get speed => $_getIZ(0);
  @$pb.TagNumber(1)
  set speed($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSpeed() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpeed() => clearField(1);

  /// The current gear selected in the car.
  @$pb.TagNumber(2)
  AdvancedState_Gear get gear => $_getN(1);
  @$pb.TagNumber(2)
  set gear(AdvancedState_Gear v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasGear() => $_has(1);
  @$pb.TagNumber(2)
  void clearGear() => clearField(2);
}

enum BasicCommand_Action {
  doorLock, 
  notSet
}

/// This contains a single basic command.
class BasicCommand extends $pb.GeneratedMessage {
  factory BasicCommand({
    DoorLockCommand? doorLock,
  }) {
    final $result = create();
    if (doorLock != null) {
      $result.doorLock = doorLock;
    }
    return $result;
  }
  BasicCommand._() : super();
  factory BasicCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BasicCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, BasicCommand_Action> _BasicCommand_ActionByTag = {
    1 : BasicCommand_Action.doorLock,
    0 : BasicCommand_Action.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BasicCommand', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.cars.virtual_car.v1'), createEmptyInstance: create)
    ..oo(0, [1])
    ..aOM<DoorLockCommand>(1, _omitFieldNames ? '' : 'doorLock', subBuilder: DoorLockCommand.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BasicCommand clone() => BasicCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BasicCommand copyWith(void Function(BasicCommand) updates) => super.copyWith((message) => updates(message as BasicCommand)) as BasicCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BasicCommand create() => BasicCommand._();
  BasicCommand createEmptyInstance() => create();
  static $pb.PbList<BasicCommand> createRepeated() => $pb.PbList<BasicCommand>();
  @$core.pragma('dart2js:noInline')
  static BasicCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BasicCommand>(create);
  static BasicCommand? _defaultInstance;

  BasicCommand_Action whichAction() => _BasicCommand_ActionByTag[$_whichOneof(0)]!;
  void clearAction() => clearField($_whichOneof(0));

  /// A lock door command.
  @$pb.TagNumber(1)
  DoorLockCommand get doorLock => $_getN(0);
  @$pb.TagNumber(1)
  set doorLock(DoorLockCommand v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDoorLock() => $_has(0);
  @$pb.TagNumber(1)
  void clearDoorLock() => clearField(1);
  @$pb.TagNumber(1)
  DoorLockCommand ensureDoorLock() => $_ensure(0);
}

/// This contains a single advanced command.
class AdvancedCommand extends $pb.GeneratedMessage {
  factory AdvancedCommand() => create();
  AdvancedCommand._() : super();
  factory AdvancedCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdvancedCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdvancedCommand', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.cars.virtual_car.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdvancedCommand clone() => AdvancedCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdvancedCommand copyWith(void Function(AdvancedCommand) updates) => super.copyWith((message) => updates(message as AdvancedCommand)) as AdvancedCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdvancedCommand create() => AdvancedCommand._();
  AdvancedCommand createEmptyInstance() => create();
  static $pb.PbList<AdvancedCommand> createRepeated() => $pb.PbList<AdvancedCommand>();
  @$core.pragma('dart2js:noInline')
  static AdvancedCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdvancedCommand>(create);
  static AdvancedCommand? _defaultInstance;
}

/// Command to lock or unlock the car's doors.
class DoorLockCommand extends $pb.GeneratedMessage {
  factory DoorLockCommand({
    $core.bool? lock,
  }) {
    final $result = create();
    if (lock != null) {
      $result.lock = lock;
    }
    return $result;
  }
  DoorLockCommand._() : super();
  factory DoorLockCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DoorLockCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DoorLockCommand', package: const $pb.PackageName(_omitMessageNames ? '' : 'opencar.cars.virtual_car.v1'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'lock')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DoorLockCommand clone() => DoorLockCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DoorLockCommand copyWith(void Function(DoorLockCommand) updates) => super.copyWith((message) => updates(message as DoorLockCommand)) as DoorLockCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DoorLockCommand create() => DoorLockCommand._();
  DoorLockCommand createEmptyInstance() => create();
  static $pb.PbList<DoorLockCommand> createRepeated() => $pb.PbList<DoorLockCommand>();
  @$core.pragma('dart2js:noInline')
  static DoorLockCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DoorLockCommand>(create);
  static DoorLockCommand? _defaultInstance;

  /// Indicate if the door should be locked or unlocked.
  @$pb.TagNumber(1)
  $core.bool get lock => $_getBF(0);
  @$pb.TagNumber(1)
  set lock($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLock() => $_has(0);
  @$pb.TagNumber(1)
  void clearLock() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
