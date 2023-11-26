import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:protobuf/protobuf.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
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
    final currentUsername = scope.snapshot.username;
    final String newUsername = map['payload']['username'];

    await scope.db.operations.insertReturning(
      OperationsCompanion.insert(
        clientId: portableOperation.clientId,
        clock: portableOperation.clock,
        payload: portableOperation.payload,
        apply: jsonEncode({
          'type': 'account/username',
          'from': currentUsername,
          'to': newUsername,
        }),
      ),
    );

    final snapshot = scope.snapshot.deepCopy()..username = newUsername;
    await scope.handleSetSnapshot(snapshot);
  }
}
