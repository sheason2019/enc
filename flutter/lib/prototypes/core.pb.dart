//
//  Generated code. Do not modify.
//  source: core.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'core.pbenum.dart';

export 'core.pbenum.dart';

class AccountSecret extends $pb.GeneratedMessage {
  factory AccountSecret() => create();
  AccountSecret._() : super();
  factory AccountSecret.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccountSecret.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AccountSecret', package: const $pb.PackageName(_omitMessageNames ? '' : 'sheason_chat'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ecdhPubKey')
    ..aOS(2, _omitFieldNames ? '' : 'ecdhPrivKey')
    ..aOS(3, _omitFieldNames ? '' : 'signPubKey')
    ..aOS(4, _omitFieldNames ? '' : 'signPrivKey')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AccountSecret clone() => AccountSecret()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AccountSecret copyWith(void Function(AccountSecret) updates) => super.copyWith((message) => updates(message as AccountSecret)) as AccountSecret;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AccountSecret create() => AccountSecret._();
  AccountSecret createEmptyInstance() => create();
  static $pb.PbList<AccountSecret> createRepeated() => $pb.PbList<AccountSecret>();
  @$core.pragma('dart2js:noInline')
  static AccountSecret getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccountSecret>(create);
  static AccountSecret? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ecdhPubKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set ecdhPubKey($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEcdhPubKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearEcdhPubKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get ecdhPrivKey => $_getSZ(1);
  @$pb.TagNumber(2)
  set ecdhPrivKey($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEcdhPrivKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearEcdhPrivKey() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get signPubKey => $_getSZ(2);
  @$pb.TagNumber(3)
  set signPubKey($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSignPubKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearSignPubKey() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get signPrivKey => $_getSZ(3);
  @$pb.TagNumber(4)
  set signPrivKey($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSignPrivKey() => $_has(3);
  @$pb.TagNumber(4)
  void clearSignPrivKey() => clearField(4);
}

class AccountIndex extends $pb.GeneratedMessage {
  factory AccountIndex() => create();
  AccountIndex._() : super();
  factory AccountIndex.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccountIndex.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AccountIndex', package: const $pb.PackageName(_omitMessageNames ? '' : 'sheason_chat'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ecdhPubKey')
    ..aOS(2, _omitFieldNames ? '' : 'signPubKey')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AccountIndex clone() => AccountIndex()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AccountIndex copyWith(void Function(AccountIndex) updates) => super.copyWith((message) => updates(message as AccountIndex)) as AccountIndex;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AccountIndex create() => AccountIndex._();
  AccountIndex createEmptyInstance() => create();
  static $pb.PbList<AccountIndex> createRepeated() => $pb.PbList<AccountIndex>();
  @$core.pragma('dart2js:noInline')
  static AccountIndex getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccountIndex>(create);
  static AccountIndex? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ecdhPubKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set ecdhPubKey($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEcdhPubKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearEcdhPubKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get signPubKey => $_getSZ(1);
  @$pb.TagNumber(2)
  set signPubKey($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSignPubKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignPubKey() => clearField(2);
}

class AccountSnapshot extends $pb.GeneratedMessage {
  factory AccountSnapshot() => create();
  AccountSnapshot._() : super();
  factory AccountSnapshot.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccountSnapshot.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AccountSnapshot', package: const $pb.PackageName(_omitMessageNames ? '' : 'sheason_chat'), createEmptyInstance: create)
    ..aOM<AccountIndex>(1, _omitFieldNames ? '' : 'index', subBuilder: AccountIndex.create)
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'avatarUrl')
    ..m<$core.String, PortableService>(4, _omitFieldNames ? '' : 'serviceMap', protoName: 'serviceMap', entryClassName: 'AccountSnapshot.ServiceMapEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: PortableService.create, valueDefaultOrMaker: PortableService.getDefault, packageName: const $pb.PackageName('sheason_chat'))
    ..a<$core.int>(5, _omitFieldNames ? '' : 'version', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AccountSnapshot clone() => AccountSnapshot()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AccountSnapshot copyWith(void Function(AccountSnapshot) updates) => super.copyWith((message) => updates(message as AccountSnapshot)) as AccountSnapshot;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AccountSnapshot create() => AccountSnapshot._();
  AccountSnapshot createEmptyInstance() => create();
  static $pb.PbList<AccountSnapshot> createRepeated() => $pb.PbList<AccountSnapshot>();
  @$core.pragma('dart2js:noInline')
  static AccountSnapshot getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccountSnapshot>(create);
  static AccountSnapshot? _defaultInstance;

  @$pb.TagNumber(1)
  AccountIndex get index => $_getN(0);
  @$pb.TagNumber(1)
  set index(AccountIndex v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearIndex() => clearField(1);
  @$pb.TagNumber(1)
  AccountIndex ensureIndex() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get avatarUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set avatarUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAvatarUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearAvatarUrl() => clearField(3);

  @$pb.TagNumber(4)
  $core.Map<$core.String, PortableService> get serviceMap => $_getMap(3);

  @$pb.TagNumber(5)
  $core.int get version => $_getIZ(4);
  @$pb.TagNumber(5)
  set version($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearVersion() => clearField(5);
}

class PortableService extends $pb.GeneratedMessage {
  factory PortableService() => create();
  PortableService._() : super();
  factory PortableService.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PortableService.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PortableService', package: const $pb.PackageName(_omitMessageNames ? '' : 'sheason_chat'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PortableService clone() => PortableService()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PortableService copyWith(void Function(PortableService) updates) => super.copyWith((message) => updates(message as PortableService)) as PortableService;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PortableService create() => PortableService._();
  PortableService createEmptyInstance() => create();
  static $pb.PbList<PortableService> createRepeated() => $pb.PbList<PortableService>();
  @$core.pragma('dart2js:noInline')
  static PortableService getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PortableService>(create);
  static PortableService? _defaultInstance;
}

class PortableSecretBox extends $pb.GeneratedMessage {
  factory PortableSecretBox() => create();
  PortableSecretBox._() : super();
  factory PortableSecretBox.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PortableSecretBox.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PortableSecretBox', package: const $pb.PackageName(_omitMessageNames ? '' : 'sheason_chat'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'cipherData', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'nonce', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'mac', $pb.PbFieldType.OY)
    ..aOM<AccountIndex>(4, _omitFieldNames ? '' : 'sender', subBuilder: AccountIndex.create)
    ..aOM<AccountIndex>(5, _omitFieldNames ? '' : 'receiver', subBuilder: AccountIndex.create)
    ..e<EcryptType>(6, _omitFieldNames ? '' : 'encryptType', $pb.PbFieldType.OE, defaultOrMaker: EcryptType.ENCRYPT_TYPE_NONE, valueOf: EcryptType.valueOf, enumValues: EcryptType.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PortableSecretBox clone() => PortableSecretBox()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PortableSecretBox copyWith(void Function(PortableSecretBox) updates) => super.copyWith((message) => updates(message as PortableSecretBox)) as PortableSecretBox;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PortableSecretBox create() => PortableSecretBox._();
  PortableSecretBox createEmptyInstance() => create();
  static $pb.PbList<PortableSecretBox> createRepeated() => $pb.PbList<PortableSecretBox>();
  @$core.pragma('dart2js:noInline')
  static PortableSecretBox getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PortableSecretBox>(create);
  static PortableSecretBox? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get cipherData => $_getN(0);
  @$pb.TagNumber(1)
  set cipherData($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCipherData() => $_has(0);
  @$pb.TagNumber(1)
  void clearCipherData() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get nonce => $_getN(1);
  @$pb.TagNumber(2)
  set nonce($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNonce() => $_has(1);
  @$pb.TagNumber(2)
  void clearNonce() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get mac => $_getN(2);
  @$pb.TagNumber(3)
  set mac($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMac() => $_has(2);
  @$pb.TagNumber(3)
  void clearMac() => clearField(3);

  @$pb.TagNumber(4)
  AccountIndex get sender => $_getN(3);
  @$pb.TagNumber(4)
  set sender(AccountIndex v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasSender() => $_has(3);
  @$pb.TagNumber(4)
  void clearSender() => clearField(4);
  @$pb.TagNumber(4)
  AccountIndex ensureSender() => $_ensure(3);

  @$pb.TagNumber(5)
  AccountIndex get receiver => $_getN(4);
  @$pb.TagNumber(5)
  set receiver(AccountIndex v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasReceiver() => $_has(4);
  @$pb.TagNumber(5)
  void clearReceiver() => clearField(5);
  @$pb.TagNumber(5)
  AccountIndex ensureReceiver() => $_ensure(4);

  @$pb.TagNumber(6)
  EcryptType get encryptType => $_getN(5);
  @$pb.TagNumber(6)
  set encryptType(EcryptType v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasEncryptType() => $_has(5);
  @$pb.TagNumber(6)
  void clearEncryptType() => clearField(6);
}

class PortableOperation extends $pb.GeneratedMessage {
  factory PortableOperation() => create();
  PortableOperation._() : super();
  factory PortableOperation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PortableOperation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PortableOperation', package: const $pb.PackageName(_omitMessageNames ? '' : 'sheason_chat'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'clientId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'clock', $pb.PbFieldType.O3)
    ..e<OperationType>(5, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: OperationType.UNKNOWN_OPEARTION, valueOf: OperationType.valueOf, enumValues: OperationType.values)
    ..aOS(6, _omitFieldNames ? '' : 'content')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PortableOperation clone() => PortableOperation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PortableOperation copyWith(void Function(PortableOperation) updates) => super.copyWith((message) => updates(message as PortableOperation)) as PortableOperation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PortableOperation create() => PortableOperation._();
  PortableOperation createEmptyInstance() => create();
  static $pb.PbList<PortableOperation> createRepeated() => $pb.PbList<PortableOperation>();
  @$core.pragma('dart2js:noInline')
  static PortableOperation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PortableOperation>(create);
  static PortableOperation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get clientId => $_getSZ(0);
  @$pb.TagNumber(1)
  set clientId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasClientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClientId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get clock => $_getIZ(1);
  @$pb.TagNumber(2)
  set clock($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClock() => $_has(1);
  @$pb.TagNumber(2)
  void clearClock() => clearField(2);

  @$pb.TagNumber(5)
  OperationType get type => $_getN(2);
  @$pb.TagNumber(5)
  set type(OperationType v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(5)
  void clearType() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get content => $_getSZ(3);
  @$pb.TagNumber(6)
  set content($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(6)
  $core.bool hasContent() => $_has(3);
  @$pb.TagNumber(6)
  void clearContent() => clearField(6);
}

class PortableConversation extends $pb.GeneratedMessage {
  factory PortableConversation() => create();
  PortableConversation._() : super();
  factory PortableConversation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PortableConversation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PortableConversation', package: const $pb.PackageName(_omitMessageNames ? '' : 'sheason_chat'), createEmptyInstance: create)
    ..e<ConversationType>(1, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: ConversationType.CONVERSATION_UNKNOWN, valueOf: ConversationType.valueOf, enumValues: ConversationType.values)
    ..pc<AccountSnapshot>(2, _omitFieldNames ? '' : 'members', $pb.PbFieldType.PM, subBuilder: AccountSnapshot.create)
    ..aOM<AccountSnapshot>(3, _omitFieldNames ? '' : 'owner', subBuilder: AccountSnapshot.create)
    ..aOS(4, _omitFieldNames ? '' : 'remoteUrl')
    ..m<$core.int, $core.List<$core.int>>(5, _omitFieldNames ? '' : 'declaredSecrets', entryClassName: 'PortableConversation.DeclaredSecretsEntry', keyFieldType: $pb.PbFieldType.O3, valueFieldType: $pb.PbFieldType.OY, packageName: const $pb.PackageName('sheason_chat'))
    ..aOM<AccountIndex>(6, _omitFieldNames ? '' : 'agent', subBuilder: AccountIndex.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PortableConversation clone() => PortableConversation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PortableConversation copyWith(void Function(PortableConversation) updates) => super.copyWith((message) => updates(message as PortableConversation)) as PortableConversation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PortableConversation create() => PortableConversation._();
  PortableConversation createEmptyInstance() => create();
  static $pb.PbList<PortableConversation> createRepeated() => $pb.PbList<PortableConversation>();
  @$core.pragma('dart2js:noInline')
  static PortableConversation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PortableConversation>(create);
  static PortableConversation? _defaultInstance;

  @$pb.TagNumber(1)
  ConversationType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(ConversationType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<AccountSnapshot> get members => $_getList(1);

  @$pb.TagNumber(3)
  AccountSnapshot get owner => $_getN(2);
  @$pb.TagNumber(3)
  set owner(AccountSnapshot v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasOwner() => $_has(2);
  @$pb.TagNumber(3)
  void clearOwner() => clearField(3);
  @$pb.TagNumber(3)
  AccountSnapshot ensureOwner() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get remoteUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set remoteUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRemoteUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearRemoteUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.Map<$core.int, $core.List<$core.int>> get declaredSecrets => $_getMap(4);

  @$pb.TagNumber(6)
  AccountIndex get agent => $_getN(5);
  @$pb.TagNumber(6)
  set agent(AccountIndex v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasAgent() => $_has(5);
  @$pb.TagNumber(6)
  void clearAgent() => clearField(6);
  @$pb.TagNumber(6)
  AccountIndex ensureAgent() => $_ensure(5);
}

class PortableMessage extends $pb.GeneratedMessage {
  factory PortableMessage() => create();
  PortableMessage._() : super();
  factory PortableMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PortableMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PortableMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'sheason_chat'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'uuid')
    ..e<MessageType>(2, _omitFieldNames ? '' : 'messageType', $pb.PbFieldType.OE, defaultOrMaker: MessageType.MESSAGE_TYPE_UNKNOWN, valueOf: MessageType.valueOf, enumValues: MessageType.values)
    ..aOS(3, _omitFieldNames ? '' : 'content')
    ..aOM<AccountSnapshot>(4, _omitFieldNames ? '' : 'sender', subBuilder: AccountSnapshot.create)
    ..aOM<PortableConversation>(5, _omitFieldNames ? '' : 'conversation', subBuilder: PortableConversation.create)
    ..pc<PortableMessageState>(6, _omitFieldNames ? '' : 'messageStates', $pb.PbFieldType.PM, subBuilder: PortableMessageState.create)
    ..aInt64(7, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PortableMessage clone() => PortableMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PortableMessage copyWith(void Function(PortableMessage) updates) => super.copyWith((message) => updates(message as PortableMessage)) as PortableMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PortableMessage create() => PortableMessage._();
  PortableMessage createEmptyInstance() => create();
  static $pb.PbList<PortableMessage> createRepeated() => $pb.PbList<PortableMessage>();
  @$core.pragma('dart2js:noInline')
  static PortableMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PortableMessage>(create);
  static PortableMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => clearField(1);

  @$pb.TagNumber(2)
  MessageType get messageType => $_getN(1);
  @$pb.TagNumber(2)
  set messageType(MessageType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessageType() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessageType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get content => $_getSZ(2);
  @$pb.TagNumber(3)
  set content($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasContent() => $_has(2);
  @$pb.TagNumber(3)
  void clearContent() => clearField(3);

  @$pb.TagNumber(4)
  AccountSnapshot get sender => $_getN(3);
  @$pb.TagNumber(4)
  set sender(AccountSnapshot v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasSender() => $_has(3);
  @$pb.TagNumber(4)
  void clearSender() => clearField(4);
  @$pb.TagNumber(4)
  AccountSnapshot ensureSender() => $_ensure(3);

  @$pb.TagNumber(5)
  PortableConversation get conversation => $_getN(4);
  @$pb.TagNumber(5)
  set conversation(PortableConversation v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasConversation() => $_has(4);
  @$pb.TagNumber(5)
  void clearConversation() => clearField(5);
  @$pb.TagNumber(5)
  PortableConversation ensureConversation() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.List<PortableMessageState> get messageStates => $_getList(5);

  @$pb.TagNumber(7)
  $fixnum.Int64 get createdAt => $_getI64(6);
  @$pb.TagNumber(7)
  set createdAt($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => clearField(7);
}

class PortableMessageState extends $pb.GeneratedMessage {
  factory PortableMessageState() => create();
  PortableMessageState._() : super();
  factory PortableMessageState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PortableMessageState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PortableMessageState', package: const $pb.PackageName(_omitMessageNames ? '' : 'sheason_chat'), createEmptyInstance: create)
    ..aOM<AccountIndex>(1, _omitFieldNames ? '' : 'accountIndex', subBuilder: AccountIndex.create)
    ..aInt64(2, _omitFieldNames ? '' : 'createdAt')
    ..aInt64(3, _omitFieldNames ? '' : 'receiveAt')
    ..aInt64(4, _omitFieldNames ? '' : 'checkedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PortableMessageState clone() => PortableMessageState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PortableMessageState copyWith(void Function(PortableMessageState) updates) => super.copyWith((message) => updates(message as PortableMessageState)) as PortableMessageState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PortableMessageState create() => PortableMessageState._();
  PortableMessageState createEmptyInstance() => create();
  static $pb.PbList<PortableMessageState> createRepeated() => $pb.PbList<PortableMessageState>();
  @$core.pragma('dart2js:noInline')
  static PortableMessageState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PortableMessageState>(create);
  static PortableMessageState? _defaultInstance;

  @$pb.TagNumber(1)
  AccountIndex get accountIndex => $_getN(0);
  @$pb.TagNumber(1)
  set accountIndex(AccountIndex v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountIndex() => clearField(1);
  @$pb.TagNumber(1)
  AccountIndex ensureAccountIndex() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get createdAt => $_getI64(1);
  @$pb.TagNumber(2)
  set createdAt($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCreatedAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatedAt() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get receiveAt => $_getI64(2);
  @$pb.TagNumber(3)
  set receiveAt($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReceiveAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearReceiveAt() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get checkedAt => $_getI64(3);
  @$pb.TagNumber(4)
  set checkedAt($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCheckedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCheckedAt() => clearField(4);
}

class SignWrapper extends $pb.GeneratedMessage {
  factory SignWrapper() => create();
  SignWrapper._() : super();
  factory SignWrapper.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignWrapper.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignWrapper', package: const $pb.PackageName(_omitMessageNames ? '' : 'sheason_chat'), createEmptyInstance: create)
    ..aOM<AccountIndex>(1, _omitFieldNames ? '' : 'signer', subBuilder: AccountIndex.create)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'buffer', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'sign', $pb.PbFieldType.OY)
    ..aOB(4, _omitFieldNames ? '' : 'encrypt')
    ..e<ContentType>(5, _omitFieldNames ? '' : 'contentType', $pb.PbFieldType.OE, defaultOrMaker: ContentType.CONTENT_BUFFER, valueOf: ContentType.valueOf, enumValues: ContentType.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignWrapper clone() => SignWrapper()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignWrapper copyWith(void Function(SignWrapper) updates) => super.copyWith((message) => updates(message as SignWrapper)) as SignWrapper;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignWrapper create() => SignWrapper._();
  SignWrapper createEmptyInstance() => create();
  static $pb.PbList<SignWrapper> createRepeated() => $pb.PbList<SignWrapper>();
  @$core.pragma('dart2js:noInline')
  static SignWrapper getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignWrapper>(create);
  static SignWrapper? _defaultInstance;

  @$pb.TagNumber(1)
  AccountIndex get signer => $_getN(0);
  @$pb.TagNumber(1)
  set signer(AccountIndex v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSigner() => $_has(0);
  @$pb.TagNumber(1)
  void clearSigner() => clearField(1);
  @$pb.TagNumber(1)
  AccountIndex ensureSigner() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get buffer => $_getN(1);
  @$pb.TagNumber(2)
  set buffer($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBuffer() => $_has(1);
  @$pb.TagNumber(2)
  void clearBuffer() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get sign => $_getN(2);
  @$pb.TagNumber(3)
  set sign($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSign() => $_has(2);
  @$pb.TagNumber(3)
  void clearSign() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get encrypt => $_getBF(3);
  @$pb.TagNumber(4)
  set encrypt($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEncrypt() => $_has(3);
  @$pb.TagNumber(4)
  void clearEncrypt() => clearField(4);

  @$pb.TagNumber(5)
  ContentType get contentType => $_getN(4);
  @$pb.TagNumber(5)
  set contentType(ContentType v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasContentType() => $_has(4);
  @$pb.TagNumber(5)
  void clearContentType() => clearField(5);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
