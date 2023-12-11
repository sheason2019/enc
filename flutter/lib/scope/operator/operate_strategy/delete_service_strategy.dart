import 'package:drift/drift.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/delete_service_atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_strategy/operate_strategy.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class DeleteServiceStrategy implements OperateStrategy {
  @override
  final Scope scope;

  @override
  final Operation operation;

  final String url;

  const DeleteServiceStrategy({
    required this.scope,
    required this.operation,
    required this.url,
  });

  @override
  Future<void> apply() async {
    final proceeder = DeleteServiceAtomProceeder();
    final atom = await proceeder.apply(scope, url);

    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    update.write(OperationsCompanion(
      atoms: Value([atom]),
    ));
  }

  @override
  Future<void> revert() async {
    final atoms = operation.atoms;
    if (atoms == null) return;
    for (final atom in atoms) {
      final proceeder = AtomProceeder.fetch(atom);
      await proceeder.revert(scope, atom);
    }

    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    update.write(const OperationsCompanion(
      atoms: Value(null),
    ));
  }
}
