import 'dart:convert';

import 'package:protobuf/protobuf.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/operation.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class Operator {
  final Scope scope;

  Operator({required this.scope});

  Future<void> apply(
    PortableOperation operation, {
    bool push = true,
  }) async {
    await _apply(operation);
    if (push) {
      await _push(operation);
    }
  }

  Future<void> _apply(PortableOperation operation) async {
    final map = jsonDecode(operation.payload);
    switch (map['type']) {
      case 'account/username':
        return _putAccountUsername(operation, map);
      default:
    }
  }

  Future<void> _push(PortableOperation operation) async {}

  Future<void> _putAccountUsername(
    PortableOperation portableOperation,
    Map map,
  ) async {
    final currentUsername = scope.snapshot.value.username;
    final String newUsername = map['payload']['username'];

    final operation = Operation(
      clock: portableOperation.clock,
      clientId: portableOperation.clientId,
      payload: portableOperation.payload,
      apply: jsonEncode({
        'type': 'account/username',
        'from': currentUsername,
        'to': newUsername,
      }),
    );

    final snapshot = scope.snapshot.value.deepCopy()..username = newUsername;

    await scope.isar.writeTxn(() => scope.isar.operations.put(operation));
    await scope.handleSetSnapshot(snapshot);
  }
}
