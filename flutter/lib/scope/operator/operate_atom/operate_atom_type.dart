import 'package:json_annotation/json_annotation.dart';

enum OperateAtomType {
  @JsonValue('put-username')
  putUsername,
  @JsonValue('put-service')
  putService,
  @JsonValue('put-contact')
  putContact,
  @JsonValue('put-conversation')
  putConversation,
  @JsonValue('put-conversation-anchor')
  putConversationAnchor,
  ;
}
