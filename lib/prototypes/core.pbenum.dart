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

import 'package:protobuf/protobuf.dart' as $pb;

class ConversationType extends $pb.ProtobufEnum {
  static const ConversationType CONVERSATION_UNKNOWN = ConversationType._(0, _omitEnumNames ? '' : 'CONVERSATION_UNKNOWN');
  static const ConversationType CONVERSATION_PRIVATE = ConversationType._(1, _omitEnumNames ? '' : 'CONVERSATION_PRIVATE');
  static const ConversationType CONVERSATION_GROUP = ConversationType._(2, _omitEnumNames ? '' : 'CONVERSATION_GROUP');

  static const $core.List<ConversationType> values = <ConversationType> [
    CONVERSATION_UNKNOWN,
    CONVERSATION_PRIVATE,
    CONVERSATION_GROUP,
  ];

  static final $core.Map<$core.int, ConversationType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ConversationType? valueOf($core.int value) => _byValue[value];

  const ConversationType._($core.int v, $core.String n) : super(v, n);
}

class MessageType extends $pb.ProtobufEnum {
  static const MessageType MESSAGE_TYPE_UNKNOWN = MessageType._(0, _omitEnumNames ? '' : 'MESSAGE_TYPE_UNKNOWN');
  static const MessageType MESSAGE_TYPE_TEXT = MessageType._(1, _omitEnumNames ? '' : 'MESSAGE_TYPE_TEXT');
  static const MessageType MESSAGE_TYPE_AUDIO = MessageType._(2, _omitEnumNames ? '' : 'MESSAGE_TYPE_AUDIO');
  static const MessageType MESSAGE_TYPE_IMAGE = MessageType._(3, _omitEnumNames ? '' : 'MESSAGE_TYPE_IMAGE');
  static const MessageType MESSAGE_TYPE_VIDEO = MessageType._(4, _omitEnumNames ? '' : 'MESSAGE_TYPE_VIDEO');
  static const MessageType MESSAGE_TYPE_FILE = MessageType._(5, _omitEnumNames ? '' : 'MESSAGE_TYPE_FILE');

  static const $core.List<MessageType> values = <MessageType> [
    MESSAGE_TYPE_UNKNOWN,
    MESSAGE_TYPE_TEXT,
    MESSAGE_TYPE_AUDIO,
    MESSAGE_TYPE_IMAGE,
    MESSAGE_TYPE_VIDEO,
    MESSAGE_TYPE_FILE,
  ];

  static final $core.Map<$core.int, MessageType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MessageType? valueOf($core.int value) => _byValue[value];

  const MessageType._($core.int v, $core.String n) : super(v, n);
}

class SignedBundleContentType extends $pb.ProtobufEnum {
  static const SignedBundleContentType BUNDLE_TYPE_UNKNOWN = SignedBundleContentType._(0, _omitEnumNames ? '' : 'BUNDLE_TYPE_UNKNOWN');
  static const SignedBundleContentType BUNDLE_TYPE_MESSAGE = SignedBundleContentType._(1, _omitEnumNames ? '' : 'BUNDLE_TYPE_MESSAGE');

  static const $core.List<SignedBundleContentType> values = <SignedBundleContentType> [
    BUNDLE_TYPE_UNKNOWN,
    BUNDLE_TYPE_MESSAGE,
  ];

  static final $core.Map<$core.int, SignedBundleContentType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SignedBundleContentType? valueOf($core.int value) => _byValue[value];

  const SignedBundleContentType._($core.int v, $core.String n) : super(v, n);
}

class EcryptType extends $pb.ProtobufEnum {
  static const EcryptType ENCRYPT_TYPE_NONE = EcryptType._(0, _omitEnumNames ? '' : 'ENCRYPT_TYPE_NONE');
  static const EcryptType ENCRYPT_TYPE_SHARED_SECRET = EcryptType._(1, _omitEnumNames ? '' : 'ENCRYPT_TYPE_SHARED_SECRET');
  static const EcryptType ENCRYPT_TYPE_DECLARED_SECRET = EcryptType._(2, _omitEnumNames ? '' : 'ENCRYPT_TYPE_DECLARED_SECRET');

  static const $core.List<EcryptType> values = <EcryptType> [
    ENCRYPT_TYPE_NONE,
    ENCRYPT_TYPE_SHARED_SECRET,
    ENCRYPT_TYPE_DECLARED_SECRET,
  ];

  static final $core.Map<$core.int, EcryptType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static EcryptType? valueOf($core.int value) => _byValue[value];

  const EcryptType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
