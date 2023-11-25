//
//  Generated code. Do not modify.
//  source: core.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use conversationTypeDescriptor instead')
const ConversationType$json = {
  '1': 'ConversationType',
  '2': [
    {'1': 'CONVERSATION_UNKNOWN', '2': 0},
    {'1': 'CONVERSATION_PRIVATE', '2': 1},
    {'1': 'CONVERSATION_GROUP', '2': 2},
  ],
};

/// Descriptor for `ConversationType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List conversationTypeDescriptor = $convert.base64Decode(
    'ChBDb252ZXJzYXRpb25UeXBlEhgKFENPTlZFUlNBVElPTl9VTktOT1dOEAASGAoUQ09OVkVSU0'
    'FUSU9OX1BSSVZBVEUQARIWChJDT05WRVJTQVRJT05fR1JPVVAQAg==');

@$core.Deprecated('Use messageTypeDescriptor instead')
const MessageType$json = {
  '1': 'MessageType',
  '2': [
    {'1': 'MESSAGE_TYPE_UNKNOWN', '2': 0},
    {'1': 'MESSAGE_TYPE_TEXT', '2': 1},
    {'1': 'MESSAGE_TYPE_AUDIO', '2': 2},
    {'1': 'MESSAGE_TYPE_IMAGE', '2': 3},
    {'1': 'MESSAGE_TYPE_VIDEO', '2': 4},
    {'1': 'MESSAGE_TYPE_FILE', '2': 5},
  ],
};

/// Descriptor for `MessageType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List messageTypeDescriptor = $convert.base64Decode(
    'CgtNZXNzYWdlVHlwZRIYChRNRVNTQUdFX1RZUEVfVU5LTk9XThAAEhUKEU1FU1NBR0VfVFlQRV'
    '9URVhUEAESFgoSTUVTU0FHRV9UWVBFX0FVRElPEAISFgoSTUVTU0FHRV9UWVBFX0lNQUdFEAMS'
    'FgoSTUVTU0FHRV9UWVBFX1ZJREVPEAQSFQoRTUVTU0FHRV9UWVBFX0ZJTEUQBQ==');

@$core.Deprecated('Use signedBundleContentTypeDescriptor instead')
const SignedBundleContentType$json = {
  '1': 'SignedBundleContentType',
  '2': [
    {'1': 'BUNDLE_TYPE_UNKNOWN', '2': 0},
    {'1': 'BUNDLE_TYPE_MESSAGE', '2': 1},
  ],
};

/// Descriptor for `SignedBundleContentType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List signedBundleContentTypeDescriptor = $convert.base64Decode(
    'ChdTaWduZWRCdW5kbGVDb250ZW50VHlwZRIXChNCVU5ETEVfVFlQRV9VTktOT1dOEAASFwoTQl'
    'VORExFX1RZUEVfTUVTU0FHRRAB');

@$core.Deprecated('Use ecryptTypeDescriptor instead')
const EcryptType$json = {
  '1': 'EcryptType',
  '2': [
    {'1': 'ENCRYPT_TYPE_NONE', '2': 0},
    {'1': 'ENCRYPT_TYPE_SHARED_SECRET', '2': 1},
    {'1': 'ENCRYPT_TYPE_DECLARED_SECRET', '2': 2},
  ],
};

/// Descriptor for `EcryptType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List ecryptTypeDescriptor = $convert.base64Decode(
    'CgpFY3J5cHRUeXBlEhUKEUVOQ1JZUFRfVFlQRV9OT05FEAASHgoaRU5DUllQVF9UWVBFX1NIQV'
    'JFRF9TRUNSRVQQARIgChxFTkNSWVBUX1RZUEVfREVDTEFSRURfU0VDUkVUEAI=');

@$core.Deprecated('Use accountSecretDescriptor instead')
const AccountSecret$json = {
  '1': 'AccountSecret',
  '2': [
    {'1': 'ecdh_pub_key', '3': 1, '4': 1, '5': 9, '10': 'ecdhPubKey'},
    {'1': 'ecdh_priv_key', '3': 2, '4': 1, '5': 9, '10': 'ecdhPrivKey'},
    {'1': 'sign_pub_key', '3': 3, '4': 1, '5': 9, '10': 'signPubKey'},
    {'1': 'sign_priv_key', '3': 4, '4': 1, '5': 9, '10': 'signPrivKey'},
  ],
};

/// Descriptor for `AccountSecret`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountSecretDescriptor = $convert.base64Decode(
    'Cg1BY2NvdW50U2VjcmV0EiAKDGVjZGhfcHViX2tleRgBIAEoCVIKZWNkaFB1YktleRIiCg1lY2'
    'RoX3ByaXZfa2V5GAIgASgJUgtlY2RoUHJpdktleRIgCgxzaWduX3B1Yl9rZXkYAyABKAlSCnNp'
    'Z25QdWJLZXkSIgoNc2lnbl9wcml2X2tleRgEIAEoCVILc2lnblByaXZLZXk=');

@$core.Deprecated('Use accountIndexDescriptor instead')
const AccountIndex$json = {
  '1': 'AccountIndex',
  '2': [
    {'1': 'ecdh_pub_key', '3': 1, '4': 1, '5': 9, '10': 'ecdhPubKey'},
    {'1': 'sign_pub_key', '3': 2, '4': 1, '5': 9, '10': 'signPubKey'},
  ],
};

/// Descriptor for `AccountIndex`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountIndexDescriptor = $convert.base64Decode(
    'CgxBY2NvdW50SW5kZXgSIAoMZWNkaF9wdWJfa2V5GAEgASgJUgplY2RoUHViS2V5EiAKDHNpZ2'
    '5fcHViX2tleRgCIAEoCVIKc2lnblB1YktleQ==');

@$core.Deprecated('Use accountSnapshotDescriptor instead')
const AccountSnapshot$json = {
  '1': 'AccountSnapshot',
  '2': [
    {'1': 'index', '3': 1, '4': 1, '5': 11, '6': '.sheason_chat.AccountIndex', '10': 'index'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'avatar_url', '3': 3, '4': 1, '5': 9, '10': 'avatarUrl'},
    {'1': 'services', '3': 4, '4': 3, '5': 9, '10': 'services'},
    {'1': 'created_at', '3': 10, '4': 1, '5': 3, '10': 'createdAt'},
  ],
};

/// Descriptor for `AccountSnapshot`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountSnapshotDescriptor = $convert.base64Decode(
    'Cg9BY2NvdW50U25hcHNob3QSMAoFaW5kZXgYASABKAsyGi5zaGVhc29uX2NoYXQuQWNjb3VudE'
    'luZGV4UgVpbmRleBIaCgh1c2VybmFtZRgCIAEoCVIIdXNlcm5hbWUSHQoKYXZhdGFyX3VybBgD'
    'IAEoCVIJYXZhdGFyVXJsEhoKCHNlcnZpY2VzGAQgAygJUghzZXJ2aWNlcxIdCgpjcmVhdGVkX2'
    'F0GAogASgDUgljcmVhdGVkQXQ=');

@$core.Deprecated('Use portableSecretBoxDescriptor instead')
const PortableSecretBox$json = {
  '1': 'PortableSecretBox',
  '2': [
    {'1': 'cipher_data', '3': 1, '4': 1, '5': 12, '10': 'cipherData'},
    {'1': 'nonce', '3': 2, '4': 1, '5': 12, '10': 'nonce'},
    {'1': 'mac', '3': 3, '4': 1, '5': 12, '10': 'mac'},
  ],
};

/// Descriptor for `PortableSecretBox`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portableSecretBoxDescriptor = $convert.base64Decode(
    'ChFQb3J0YWJsZVNlY3JldEJveBIfCgtjaXBoZXJfZGF0YRgBIAEoDFIKY2lwaGVyRGF0YRIUCg'
    'Vub25jZRgCIAEoDFIFbm9uY2USEAoDbWFjGAMgASgMUgNtYWM=');

@$core.Deprecated('Use portableOperationDescriptor instead')
const PortableOperation$json = {
  '1': 'PortableOperation',
  '2': [
    {'1': 'client_id', '3': 1, '4': 1, '5': 9, '10': 'clientId'},
    {'1': 'clock', '3': 2, '4': 1, '5': 5, '10': 'clock'},
    {'1': 'payload', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'payload', '17': true},
    {'1': 'secret_box', '3': 4, '4': 1, '5': 11, '6': '.sheason_chat.PortableSecretBox', '9': 1, '10': 'secretBox', '17': true},
  ],
  '8': [
    {'1': '_payload'},
    {'1': '_secret_box'},
  ],
};

/// Descriptor for `PortableOperation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portableOperationDescriptor = $convert.base64Decode(
    'ChFQb3J0YWJsZU9wZXJhdGlvbhIbCgljbGllbnRfaWQYASABKAlSCGNsaWVudElkEhQKBWNsb2'
    'NrGAIgASgFUgVjbG9jaxIdCgdwYXlsb2FkGAMgASgJSABSB3BheWxvYWSIAQESQwoKc2VjcmV0'
    'X2JveBgEIAEoCzIfLnNoZWFzb25fY2hhdC5Qb3J0YWJsZVNlY3JldEJveEgBUglzZWNyZXRCb3'
    'iIAQFCCgoIX3BheWxvYWRCDQoLX3NlY3JldF9ib3g=');

@$core.Deprecated('Use portableConversationDescriptor instead')
const PortableConversation$json = {
  '1': 'PortableConversation',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.sheason_chat.ConversationType', '10': 'type'},
    {'1': 'members', '3': 2, '4': 3, '5': 11, '6': '.sheason_chat.AccountIndex', '10': 'members'},
    {'1': 'owner', '3': 3, '4': 1, '5': 11, '6': '.sheason_chat.AccountIndex', '10': 'owner'},
    {'1': 'remote_url', '3': 4, '4': 1, '5': 9, '10': 'remoteUrl'},
    {'1': 'declared_secrets', '3': 5, '4': 3, '5': 11, '6': '.sheason_chat.PortableConversation.DeclaredSecretsEntry', '10': 'declaredSecrets'},
  ],
  '3': [PortableConversation_DeclaredSecretsEntry$json],
};

@$core.Deprecated('Use portableConversationDescriptor instead')
const PortableConversation_DeclaredSecretsEntry$json = {
  '1': 'DeclaredSecretsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `PortableConversation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portableConversationDescriptor = $convert.base64Decode(
    'ChRQb3J0YWJsZUNvbnZlcnNhdGlvbhIyCgR0eXBlGAEgASgOMh4uc2hlYXNvbl9jaGF0LkNvbn'
    'ZlcnNhdGlvblR5cGVSBHR5cGUSNAoHbWVtYmVycxgCIAMoCzIaLnNoZWFzb25fY2hhdC5BY2Nv'
    'dW50SW5kZXhSB21lbWJlcnMSMAoFb3duZXIYAyABKAsyGi5zaGVhc29uX2NoYXQuQWNjb3VudE'
    'luZGV4UgVvd25lchIdCgpyZW1vdGVfdXJsGAQgASgJUglyZW1vdGVVcmwSYgoQZGVjbGFyZWRf'
    'c2VjcmV0cxgFIAMoCzI3LnNoZWFzb25fY2hhdC5Qb3J0YWJsZUNvbnZlcnNhdGlvbi5EZWNsYX'
    'JlZFNlY3JldHNFbnRyeVIPZGVjbGFyZWRTZWNyZXRzGkIKFERlY2xhcmVkU2VjcmV0c0VudHJ5'
    'EhAKA2tleRgBIAEoBVIDa2V5EhQKBXZhbHVlGAIgASgMUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use portableMessageDescriptor instead')
const PortableMessage$json = {
  '1': 'PortableMessage',
  '2': [
    {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    {'1': 'message_type', '3': 2, '4': 1, '5': 14, '6': '.sheason_chat.MessageType', '10': 'messageType'},
    {'1': 'content', '3': 3, '4': 1, '5': 9, '10': 'content'},
    {'1': 'sender', '3': 4, '4': 1, '5': 11, '6': '.sheason_chat.AccountIndex', '10': 'sender'},
    {'1': 'conversation', '3': 5, '4': 1, '5': 11, '6': '.sheason_chat.PortableConversation', '10': 'conversation'},
    {'1': 'message_states', '3': 6, '4': 3, '5': 11, '6': '.sheason_chat.PortableMessageState', '10': 'messageStates'},
  ],
};

/// Descriptor for `PortableMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portableMessageDescriptor = $convert.base64Decode(
    'Cg9Qb3J0YWJsZU1lc3NhZ2USEgoEdXVpZBgBIAEoCVIEdXVpZBI8CgxtZXNzYWdlX3R5cGUYAi'
    'ABKA4yGS5zaGVhc29uX2NoYXQuTWVzc2FnZVR5cGVSC21lc3NhZ2VUeXBlEhgKB2NvbnRlbnQY'
    'AyABKAlSB2NvbnRlbnQSMgoGc2VuZGVyGAQgASgLMhouc2hlYXNvbl9jaGF0LkFjY291bnRJbm'
    'RleFIGc2VuZGVyEkYKDGNvbnZlcnNhdGlvbhgFIAEoCzIiLnNoZWFzb25fY2hhdC5Qb3J0YWJs'
    'ZUNvbnZlcnNhdGlvblIMY29udmVyc2F0aW9uEkkKDm1lc3NhZ2Vfc3RhdGVzGAYgAygLMiIuc2'
    'hlYXNvbl9jaGF0LlBvcnRhYmxlTWVzc2FnZVN0YXRlUg1tZXNzYWdlU3RhdGVz');

@$core.Deprecated('Use portableMessageStateDescriptor instead')
const PortableMessageState$json = {
  '1': 'PortableMessageState',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.sheason_chat.AccountIndex', '10': 'account'},
    {'1': 'created_at', '3': 2, '4': 1, '5': 3, '10': 'createdAt'},
    {'1': 'receive_at', '3': 3, '4': 1, '5': 3, '10': 'receiveAt'},
    {'1': 'checked_at', '3': 4, '4': 1, '5': 3, '10': 'checkedAt'},
  ],
};

/// Descriptor for `PortableMessageState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portableMessageStateDescriptor = $convert.base64Decode(
    'ChRQb3J0YWJsZU1lc3NhZ2VTdGF0ZRI0CgdhY2NvdW50GAEgASgLMhouc2hlYXNvbl9jaGF0Lk'
    'FjY291bnRJbmRleFIHYWNjb3VudBIdCgpjcmVhdGVkX2F0GAIgASgDUgljcmVhdGVkQXQSHQoK'
    'cmVjZWl2ZV9hdBgDIAEoA1IJcmVjZWl2ZUF0Eh0KCmNoZWNrZWRfYXQYBCABKANSCWNoZWNrZW'
    'RBdA==');

@$core.Deprecated('Use signedBundleDescriptor instead')
const SignedBundle$json = {
  '1': 'SignedBundle',
  '2': [
    {'1': 'encrypt_type', '3': 1, '4': 1, '5': 14, '6': '.sheason_chat.EcryptType', '10': 'encryptType'},
    {'1': 'secret_key', '3': 2, '4': 1, '5': 5, '10': 'secretKey'},
    {'1': 'sender', '3': 3, '4': 1, '5': 11, '6': '.sheason_chat.AccountIndex', '10': 'sender'},
    {'1': 'receiver', '3': 4, '4': 1, '5': 11, '6': '.sheason_chat.AccountIndex', '10': 'receiver'},
    {'1': 'plain_data', '3': 5, '4': 1, '5': 12, '10': 'plainData'},
    {'1': 'secret_box', '3': 6, '4': 1, '5': 11, '6': '.sheason_chat.PortableSecretBox', '10': 'secretBox'},
    {'1': 'content_type', '3': 7, '4': 1, '5': 14, '6': '.sheason_chat.SignedBundleContentType', '10': 'contentType'},
  ],
};

/// Descriptor for `SignedBundle`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signedBundleDescriptor = $convert.base64Decode(
    'CgxTaWduZWRCdW5kbGUSOwoMZW5jcnlwdF90eXBlGAEgASgOMhguc2hlYXNvbl9jaGF0LkVjcn'
    'lwdFR5cGVSC2VuY3J5cHRUeXBlEh0KCnNlY3JldF9rZXkYAiABKAVSCXNlY3JldEtleRIyCgZz'
    'ZW5kZXIYAyABKAsyGi5zaGVhc29uX2NoYXQuQWNjb3VudEluZGV4UgZzZW5kZXISNgoIcmVjZW'
    'l2ZXIYBCABKAsyGi5zaGVhc29uX2NoYXQuQWNjb3VudEluZGV4UghyZWNlaXZlchIdCgpwbGFp'
    'bl9kYXRhGAUgASgMUglwbGFpbkRhdGESPgoKc2VjcmV0X2JveBgGIAEoCzIfLnNoZWFzb25fY2'
    'hhdC5Qb3J0YWJsZVNlY3JldEJveFIJc2VjcmV0Qm94EkgKDGNvbnRlbnRfdHlwZRgHIAEoDjIl'
    'LnNoZWFzb25fY2hhdC5TaWduZWRCdW5kbGVDb250ZW50VHlwZVILY29udGVudFR5cGU=');

