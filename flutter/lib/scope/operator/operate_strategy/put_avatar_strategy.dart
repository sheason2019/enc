import 'package:drift/drift.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/operator/context.dart';
import 'package:ENC/scope/operator/operate_atom/operate_atom.dart';
import 'package:ENC/scope/operator/operate_atom/proceeders/atom_proceeder.dart';
import 'package:ENC/scope/operator/operate_atom/proceeders/put_avatar_atom_proceeder.dart';
import 'package:ENC/scope/operator/operate_atom/proceeders/put_contact_atom_proceeder.dart';

import 'operate_strategy.dart';

class PutAvatarStrategy implements OperateStrategy {
  @override
  final OperateContext context;
  @override
  final Operation operation;

  final String url;

  PutAvatarStrategy({
    required this.context,
    required this.operation,
    required this.url,
  });

  @override
  Future<void> apply() async {
    final scope = context.scope;
    final atoms = <OperateAtom>[];
    {
      final proceeder = PutAvatarAtomProceeder();
      final atom = await proceeder.apply(context, url);
      atoms.add(atom);
    }
    {
      final contactProceeder = PutContactAtomProceeder();
      final atom = await contactProceeder.apply(
        context,
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
    final scope = context.scope;
    for (final atom in operation.atoms!) {
      final proceeder = AtomProceeder.fetch(atom);
      await proceeder.revert(context, atom);
    }

    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    await update.write(const OperationsCompanion(
      atoms: Value(null),
    ));
  }
}
