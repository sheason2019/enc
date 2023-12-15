import 'dart:convert';

import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/operator/operate_strategy/delete_service_strategy.dart';
import 'package:sheason_chat/scope/operator/operate_strategy/put_avatar_strategy.dart';
import 'package:sheason_chat/scope/operator/operate_strategy/put_contact_strategy.dart';
import 'package:sheason_chat/scope/operator/operate_strategy/put_conversation_anchor_strategy.dart';
import 'package:sheason_chat/scope/operator/operate_strategy/put_message_strategy.dart';
import 'package:sheason_chat/scope/operator/operate_strategy/put_username_strategy.dart';
import 'package:sheason_chat/scope/scope.model.dart';

import 'put_conversation_strategy.dart';
import 'put_service_strategy.dart';

abstract class OperateStrategy {
  Scope get scope;
  Operation get operation;

  Future<void> apply();
  Future<void> revert();

  factory OperateStrategy.create(
    Scope scope,
    Operation operation, {
    bool notifyMessage = false,
  }) {
    switch (operation.info.type) {
      case OperationType.PUT_USERNAME:
        return PutUsernameStrategy(
          scope: scope,
          operation: operation,
          username: operation.info.content,
        );
      case OperationType.PUT_AVATAR:
        return PutAvatarStrategy(
          scope: scope,
          operation: operation,
          url: operation.info.content,
        );
      case OperationType.PUT_SERVICE:
        return PutServiceStrategy(
          scope: scope,
          operation: operation,
          serviceUrl: operation.info.content,
        );
      case OperationType.PUT_CONTACT:
        return PutContactStrategy(
          scope: scope,
          operation: operation,
          snapshot: AccountSnapshot.fromBuffer(
            base64Decode(operation.info.content),
          ),
        );
      case OperationType.PUT_CONVERSATION:
        return PutConversationStrategy(
          scope: scope,
          operation: operation,
          portable: PortableConversation.fromBuffer(
            base64Decode(operation.info.content),
          ),
        );
      case OperationType.PUT_CONVERSATION_ANCHOR:
        return PutConversationAnchorStrategy(
          scope: scope,
          operation: operation,
          portable: PortableConversation.fromBuffer(
            base64Decode(operation.info.content),
          ),
        );
      case OperationType.PUT_MESSAGE:
        return PutMessageStrategy(
          scope: scope,
          operation: operation,
          wrapper: SignWrapper.fromBuffer(
            base64Decode(operation.info.content),
          ),
          notifyMessage: notifyMessage,
        );
      case OperationType.DELETE_SERVICE:
        return DeleteServiceStrategy(
          scope: scope,
          operation: operation,
          url: operation.info.content,
        );
      case OperationType.UNKNOWN_OPEARTION:
        break;
    }
    throw UnimplementedError();
  }
}
