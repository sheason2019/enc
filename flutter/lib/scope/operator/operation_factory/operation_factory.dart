import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/scope/scope.model.dart';

class OperationFactory {
  final Scope scope;
  OperationFactory(this.scope) {
    initial();
  }

  Future<PortableOperation> username(String username) async {
    final operation = await _createWithClock(OperationType.PUT_USERNAME);
    operation.content = username;
    return operation;
  }

  Future<PortableOperation> avatar(String url) async {
    final operation = await _createWithClock(OperationType.PUT_AVATAR);
    operation.content = url;
    return operation;
  }

  Future<PortableOperation> service(String service) async {
    final operation = await _createWithClock(OperationType.PUT_SERVICE);
    operation.content = service;
    return operation;
  }

  Future<PortableOperation> deleteService(String service) async {
    final operation = await _createWithClock(OperationType.DELETE_SERVICE);
    operation.content = service;
    return operation;
  }

  Future<PortableOperation> contact(AccountSnapshot snapshot) async {
    final operation = await _createWithClock(OperationType.PUT_CONTACT);
    operation.content = base64Encode(snapshot.writeToBuffer());
    return operation;
  }

  Future<PortableOperation> conversation(
    PortableConversation conversation,
  ) async {
    final operation = await _createWithClock(OperationType.PUT_CONVERSATION);
    operation.content = base64Encode(conversation.writeToBuffer());
    return operation;
  }

  Future<PortableOperation> conversationAnchor(
    PortableConversation conversation,
  ) async {
    final operation = await _createWithClock(
      OperationType.PUT_CONVERSATION_ANCHOR,
    );
    operation.content = base64Encode(conversation.writeToBuffer());
    return operation;
  }

  Future<PortableOperation> message(SignWrapper wrapper) async {
    final operation = await _createWithClock(
      OperationType.PUT_MESSAGE,
    );
    operation.content = base64Encode(wrapper.writeToBuffer());
    return operation;
  }

  Future<PortableOperation> _createWithClock(
    OperationType type,
  ) async {
    await _initC.future;
    return PortableOperation()
      ..clientId = scope.deviceId
      ..clock = clock++
      ..type = type;
  }

  late int clock;
  final _initC = Completer();
  Future<void> initial() async {
    final maxClock = scope.db.operations.clock.max();
    final selectCurrentClock = scope.db.operations.selectOnly()
      ..addColumns([maxClock]);
    final record = await selectCurrentClock.getSingleOrNull();
    final currentClock = record?.read(maxClock) ?? 0;
    clock = currentClock + 1;
    if (!_initC.isCompleted) _initC.complete();
  }
}
