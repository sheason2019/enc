import 'package:drift/drift.dart';
import 'package:protobuf/protobuf.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/operator/context.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_contact_atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_username_atom_proceeder.dart';

import 'operate_strategy.dart';

class PutUsernameStrategy implements OperateStrategy {
  @override
  final OperateContext context;
  @override
  final Operation operation;

  final String username;

  PutUsernameStrategy({
    required this.context,
    required this.operation,
    required this.username,
  });

  @override
  Future<void> apply() async {
    final scope = context.scope;
    final atoms = <OperateAtom>[];
    {
      final proceeder = PutUsernameAtomProceeder();
      final atom = await proceeder.apply(context, username);
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

    final snapshot = scope.snapshot.deepCopy()..username = username;
    await scope.handleSetSnapshot(snapshot);
  }
}
