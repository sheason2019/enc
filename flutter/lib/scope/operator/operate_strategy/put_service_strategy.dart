import 'package:drift/drift.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_service_atom_proceeder.dart';
import 'package:sheason_chat/scope/scope.model.dart';

import 'operate_strategy.dart';

class PutServiceStrategy implements OperateStrategy {
  @override
  final Operation operation;
  @override
  final Scope scope;

  final String serviceUrl;

  PutServiceStrategy({
    required this.scope,
    required this.operation,
    required this.serviceUrl,
  });

  @override
  Future<void> apply() async {
    final proceeder = PutServiceAtomProceeder();
    final atom = await proceeder.apply(scope, serviceUrl);

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
  }
}
