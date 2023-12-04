import 'package:drift/drift.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_contact_atom_proceeder.dart';
import 'package:sheason_chat/scope/scope.model.dart';

import 'operate_strategy.dart';

class PutContactStrategy implements OperateStrategy {
  @override
  final Operation operation;

  @override
  final Scope scope;

  final AccountSnapshot snapshot;

  const PutContactStrategy({
    required this.scope,
    required this.operation,
    required this.snapshot,
  });

  @override
  Future<void> apply() async {
    final proceeder = PutContactAtomProceeder();
    final atom = await proceeder.apply(scope, snapshot);

    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    await update.replace(OperationsCompanion(
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
    await update.replace(const OperationsCompanion(
      atoms: Value(null),
    ));
  }
}
