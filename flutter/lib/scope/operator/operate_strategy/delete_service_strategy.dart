import 'package:drift/drift.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/operator/context.dart';
import 'package:ENC/scope/operator/operate_atom/proceeders/atom_proceeder.dart';
import 'package:ENC/scope/operator/operate_atom/proceeders/delete_service_atom_proceeder.dart';
import 'package:ENC/scope/operator/operate_strategy/operate_strategy.dart';

class DeleteServiceStrategy implements OperateStrategy {
  @override
  final OperateContext context;

  @override
  final Operation operation;

  final String url;

  const DeleteServiceStrategy({
    required this.context,
    required this.operation,
    required this.url,
  });

  @override
  Future<void> apply() async {
    final scope = context.scope;
    final proceeder = DeleteServiceAtomProceeder();
    final atom = await proceeder.apply(context, url);

    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    update.write(OperationsCompanion(
      atoms: Value([atom]),
    ));
  }

  @override
  Future<void> revert() async {
    final scope = context.scope;
    final atoms = operation.atoms;
    if (atoms == null) return;
    for (final atom in atoms) {
      final proceeder = AtomProceeder.fetch(atom);
      await proceeder.revert(context, atom);
    }

    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    update.write(const OperationsCompanion(
      atoms: Value(null),
    ));
  }
}
