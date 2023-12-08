import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class OperationFactory {
  final Scope scope;
  OperationFactory(this.scope);

  Future<PortableOperation> username(String username) async {
    final operation = await _createWithClock(OperationType.PUT_USERNAME, 0);
    operation.content = username;
    return operation;
  }

  Future<PortableOperation> service(String service) async {
    final operation = await _createWithClock(OperationType.PUT_SERVICE, 0);
    operation.content = service;
    return operation;
  }

  Future<PortableOperation> contact(AccountSnapshot snapshot) async {
    final operation = await _createWithClock(OperationType.PUT_CONTACT, 0);
    operation.content = base64Encode(snapshot.writeToBuffer());
    return operation;
  }

  Future<PortableOperation> conversation(
    PortableConversation conversation,
  ) async {
    final operation = await _createWithClock(OperationType.PUT_CONVERSATION, 0);
    operation.content = base64Encode(conversation.writeToBuffer());
    return operation;
  }

  Future<PortableOperation> conversationAnchor(
    PortableConversation conversation,
  ) async {
    final operation = await _createWithClock(
      OperationType.PUT_CONVERSATION_ANCHOR,
      0,
    );
    operation.content = base64Encode(conversation.writeToBuffer());
    return operation;
  }

  Future<PortableOperation> message(
    SignWrapper wrapper, {
    int offset = 0,
  }) async {
    final operation = await _createWithClock(
      OperationType.PUT_MESSAGE,
      offset,
    );
    operation.content = base64Encode(wrapper.writeToBuffer());
    return operation;
  }

  Future<PortableOperation> _createWithClock(
    OperationType type,
    int offset,
  ) async {
    final maxClock = scope.db.operations.clock.max();
    final selectCurrentClock = scope.db.operations.selectOnly()
      ..addColumns([maxClock]);
    final record = await selectCurrentClock.getSingleOrNull();
    final currentClock = record?.read(maxClock) ?? 0;
    return PortableOperation()
      ..clientId = scope.deviceId
      ..clock = currentClock + 1 + offset
      ..type = type;
  }
}
