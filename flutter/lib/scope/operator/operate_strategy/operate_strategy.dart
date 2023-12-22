import 'dart:convert';

import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/operator/context.dart';
import 'package:ENC/scope/operator/operate_strategy/delete_service_strategy.dart';
import 'package:ENC/scope/operator/operate_strategy/put_avatar_strategy.dart';
import 'package:ENC/scope/operator/operate_strategy/put_contact_strategy.dart';
import 'package:ENC/scope/operator/operate_strategy/put_conversation_anchor_strategy.dart';
import 'package:ENC/scope/operator/operate_strategy/put_message_strategy.dart';
import 'package:ENC/scope/operator/operate_strategy/put_username_strategy.dart';

import 'put_conversation_strategy.dart';
import 'put_service_strategy.dart';

abstract class OperateStrategy {
  OperateContext get context;
  Operation get operation;

  Future<void> apply();
  Future<void> revert();

  factory OperateStrategy.create(
    OperateContext context,
    Operation operation,
  ) {
    switch (operation.info.type) {
      case OperationType.PUT_USERNAME:
        return PutUsernameStrategy(
          context: context,
          operation: operation,
          username: operation.info.content,
        );
      case OperationType.PUT_AVATAR:
        return PutAvatarStrategy(
          context: context,
          operation: operation,
          url: operation.info.content,
        );
      case OperationType.PUT_SERVICE:
        return PutServiceStrategy(
          context: context,
          operation: operation,
          serviceUrl: operation.info.content,
        );
      case OperationType.PUT_CONTACT:
        return PutContactStrategy(
          context: context,
          operation: operation,
          snapshot: AccountSnapshot.fromBuffer(
            base64Decode(operation.info.content),
          ),
        );
      case OperationType.PUT_CONVERSATION:
        return PutConversationStrategy(
          context: context,
          operation: operation,
          portable: PortableConversation.fromBuffer(
            base64Decode(operation.info.content),
          ),
        );
      case OperationType.PUT_CONVERSATION_ANCHOR:
        return PutConversationAnchorStrategy(
          context: context,
          operation: operation,
          portable: PortableConversation.fromBuffer(
            base64Decode(operation.info.content),
          ),
        );
      case OperationType.PUT_MESSAGE:
        return PutMessageStrategy(
          context: context,
          operation: operation,
          wrapper: SignWrapper.fromBuffer(
            base64Decode(operation.info.content),
          ),
        );
      case OperationType.DELETE_SERVICE:
        return DeleteServiceStrategy(
          context: context,
          operation: operation,
          url: operation.info.content,
        );
      case OperationType.UNKNOWN_OPEARTION:
        break;
    }
    throw UnimplementedError();
  }
}
