import 'package:json_annotation/json_annotation.dart';

enum OperateAtomType {
  @JsonValue('put-username')
  putUsername,
  @JsonValue('put-service')
  putService,
  @JsonValue('delete-service')
  deleteService,
  @JsonValue('put-contact')
  putContact,
  @JsonValue('put-conversation')
  putConversation,
  @JsonValue('put-conversation-anchor')
  putConversationAnchor,
  @JsonValue('put-message')
  putMessage,
  @JsonValue('put-message-state')
  putMessageState,
  @JsonValue('put-message-signature')
  putMessageSignature,
  ;
}
