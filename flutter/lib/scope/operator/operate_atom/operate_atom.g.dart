// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operate_atom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperateAtom _$OperateAtomFromJson(Map<String, dynamic> json) => OperateAtom(
      type: $enumDecode(_$OperateAtomTypeEnumMap, json['type']),
      from: json['from'] as String?,
      to: json['to'] as String,
      extra: json['extra'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$OperateAtomToJson(OperateAtom instance) =>
    <String, dynamic>{
      'type': _$OperateAtomTypeEnumMap[instance.type]!,
      'from': instance.from,
      'to': instance.to,
      'extra': instance.extra,
    };

const _$OperateAtomTypeEnumMap = {
  OperateAtomType.putUsername: 'put-username',
  OperateAtomType.putAvatar: 'put-avatar',
  OperateAtomType.putService: 'put-service',
  OperateAtomType.deleteService: 'delete-service',
  OperateAtomType.putContact: 'put-contact',
  OperateAtomType.putConversation: 'put-conversation',
  OperateAtomType.putConversationAnchor: 'put-conversation-anchor',
  OperateAtomType.putMessage: 'put-message',
  OperateAtomType.putMessageState: 'put-message-state',
  OperateAtomType.putMessageSignature: 'put-message-signature',
};
