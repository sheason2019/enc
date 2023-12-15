import 'package:drift/drift.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_avatar_atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_contact_atom_proceeder.dart';
import 'package:sheason_chat/scope/scope.model.dart';

import 'operate_strategy.dart';

class PutAvatarStrategy implements OperateStrategy {
  @override
  final Scope scope;
  @override
  final Operation operation;

  final String url;

  PutAvatarStrategy({
    required this.scope,
    required this.operation,
    required this.url,
  });

  @override
  Future<void> apply() async {
    final atoms = <OperateAtom>[];
    {
      final proceeder = PutAvatarAtomProceeder();
      final atom = await proceeder.apply(scope, url);
      atoms.add(atom);
    }
    {
      final contactProceeder = PutContactAtomProceeder();
      final atom = await contactProceeder.apply(
        scope,
        scope.snapshot,
      );
      if (atom != null) {
        atoms.add(atom);
      }
    }

    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    await update.write(OperationsCompanion(
      atoms: Value(atoms),
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
