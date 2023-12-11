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

class OperationType extends $pb.ProtobufEnum {
  static const OperationType UNKNOWN_OPEARTION = OperationType._(0, _omitEnumNames ? '' : 'UNKNOWN_OPEARTION');
  static const OperationType PUT_USERNAME = OperationType._(1, _omitEnumNames ? '' : 'PUT_USERNAME');
  static const OperationType PUT_SERVICE = OperationType._(2, _omitEnumNames ? '' : 'PUT_SERVICE');
  static const OperationType PUT_CONTACT = OperationType._(3, _omitEnumNames ? '' : 'PUT_CONTACT');
  static const OperationType PUT_CONVERSATION = OperationType._(4, _omitEnumNames ? '' : 'PUT_CONVERSATION');
  static const OperationType PUT_CONVERSATION_ANCHOR = OperationType._(5, _omitEnumNames ? '' : 'PUT_CONVERSATION_ANCHOR');
  static const OperationType PUT_MESSAGE = OperationType._(6, _omitEnumNames ? '' : 'PUT_MESSAGE');
  static const OperationType DELETE_SERVICE = OperationType._(101, _omitEnumNames ? '' : 'DELETE_SERVICE');

  static const $core.List<OperationType> values = <OperationType> [
    UNKNOWN_OPEARTION,
    PUT_USERNAME,
    PUT_SERVICE,
    PUT_CONTACT,
    PUT_CONVERSATION,
    PUT_CONVERSATION_ANCHOR,
    PUT_MESSAGE,
    DELETE_SERVICE,
  ];

  static final $core.Map<$core.int, OperationType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static OperationType? valueOf($core.int value) => _byValue[value];

  const OperationType._($core.int v, $core.String n) : super(v, n);
}

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
  static const MessageType MESSAGE_TYPE_RTC = MessageType._(6, _omitEnumNames ? '' : 'MESSAGE_TYPE_RTC');
  static const MessageType MESSAGE_TYPE_STATE_ONLY = MessageType._(101, _omitEnumNames ? '' : 'MESSAGE_TYPE_STATE_ONLY');

  static const $core.List<MessageType> values = <MessageType> [
    MESSAGE_TYPE_UNKNOWN,
    MESSAGE_TYPE_TEXT,
    MESSAGE_TYPE_AUDIO,
    MESSAGE_TYPE_IMAGE,
    MESSAGE_TYPE_VIDEO,
    MESSAGE_TYPE_FILE,
    MESSAGE_TYPE_RTC,
    MESSAGE_TYPE_STATE_ONLY,
  ];

  static final $core.Map<$core.int, MessageType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MessageType? valueOf($core.int value) => _byValue[value];

  const MessageType._($core.int v, $core.String n) : super(v, n);
}

class ContentType extends $pb.ProtobufEnum {
  static const ContentType CONTENT_BUFFER = ContentType._(0, _omitEnumNames ? '' : 'CONTENT_BUFFER');
  static const ContentType CONTENT_MESSAGE = ContentType._(1, _omitEnumNames ? '' : 'CONTENT_MESSAGE');
  static const ContentType CONTENT_OPERATION = ContentType._(2, _omitEnumNames ? '' : 'CONTENT_OPERATION');

  static const $core.List<ContentType> values = <ContentType> [
    CONTENT_BUFFER,
    CONTENT_MESSAGE,
    CONTENT_OPERATION,
  ];

  static final $core.Map<$core.int, ContentType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ContentType? valueOf($core.int value) => _byValue[value];

  const ContentType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
