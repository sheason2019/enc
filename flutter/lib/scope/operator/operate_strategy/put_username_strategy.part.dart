import 'package:drift/drift.dart';
import 'package:protobuf/protobuf.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_username_atom_proceeder.dart';
import 'package:sheason_chat/scope/scope.model.dart';

import 'operate_strategy.dart';

class PutUsernameStrategy implements OperateStrategy {
  @override
  final Scope scope;
  @override
  final Operation operation;

  final String username;

  PutUsernameStrategy({
    required this.scope,
    required this.operation,
    required this.username,
  });

  @override
  Future<void> apply() async {
    final proceeder = PutUsernameAtomProceeder();
    final atom = await proceeder.apply(scope, username);

    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    await update.write(OperationsCompanion(
      atoms: Value([atom]),
    ));
  }

  @override
  Future<void> revert() async {
    for (final atom in operation.atoms!) {
      final proceeder = AtomProceeder.fetch(atom);
      await proceeder.revert(scope, atom);
    }

    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    await update.write(const OperationsCompanion(
      atoms: Value(null),
    ));

    final snapshot = scope.snapshot.deepCopy()..username = username;
    await scope.handleSetSnapshot(snapshot);
  }
}
