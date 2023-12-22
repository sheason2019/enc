import 'package:drift/drift.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/operator/context.dart';
import 'package:ENC/scope/operator/operate_atom/operate_atom.dart';
import 'package:ENC/scope/operator/operate_atom/proceeders/atom_proceeder.dart';
import 'package:ENC/scope/operator/operate_atom/proceeders/put_contact_atom_proceeder.dart';
import 'package:ENC/scope/operator/operate_atom/proceeders/put_conversation_atom_proceeder.dart';

import 'operate_strategy.dart';

class PutConversationStrategy implements OperateStrategy {
  @override
  final Operation operation;
  @override
  final OperateContext context;

  final PortableConversation portable;

  const PutConversationStrategy({
    required this.context,
    required this.operation,
    required this.portable,
  });

  @override
  Future<void> apply() async {
    final scope = context.scope;
    final atoms = <OperateAtom>[];
    final contactProceeder = PutContactAtomProceeder();
    for (final member in portable.members) {
      final atom = await contactProceeder.apply(context, member);
      if (atom != null) {
        atoms.add(atom);
      }
    }

    final putConversationAtom = await PutConversationAtomProceeder().apply(
      context,
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
    final scope = context.scope;
    for (final atom in operation.atoms!.reversed) {
      final proceeder = AtomProceeder.fetch(atom);
      await proceeder.revert(context, atom);
    }

    // revert operation apply
    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    await update.write(const OperationsCompanion(
      atoms: Value(null),
    ));
  }
}
