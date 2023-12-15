import 'package:drift/drift.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_contact_atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_conversation_atom_proceeder.dart';
import 'package:sheason_chat/scope/scope.model.dart';

import 'operate_strategy.dart';

class PutConversationStrategy implements OperateStrategy {
  @override
  final Operation operation;
  @override
  final Scope scope;

  final PortableConversation portable;

  const PutConversationStrategy({
    required this.scope,
    required this.operation,
    required this.portable,
  });

  @override
  Future<void> apply() async {
    final atoms = <OperateAtom>[];
    final contactProceeder = PutContactAtomProceeder();
    for (final member in portable.members) {
      final atom = await contactProceeder.apply(scope, member);
      if (atom != null) {
        atoms.add(atom);
      }
    }

    final putConversationAtom = await PutConversationAtomProceeder().apply(
      scope,
      portable,
    );
    if (putConversationAtom != null) {
      atoms.add(putConversationAtom);
    }

    final updateOperation = scope.db.operations.update();
    updateOperation.where((tbl) => tbl.id.equals(operation.id));
    await updateOperation.write(OperationsCompanion(
      atoms: Value(atoms),
    ));
  }

  @override
  Future<void> revert() async {
    for (final atom in operation.atoms!.reversed) {
      final proceeder = AtomProceeder.fetch(atom);
      await proceeder.revert(scope, atom);
    }

    // revert operation apply
    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    await update.write(const OperationsCompanion(
      atoms: Value(null),
    ));
  }
}
