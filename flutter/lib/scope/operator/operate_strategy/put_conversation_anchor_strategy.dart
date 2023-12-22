import 'package:drift/drift.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/operator/context.dart';
import 'package:ENC/scope/operator/operate_atom/proceeders/atom_proceeder.dart';
import 'package:ENC/scope/operator/operate_atom/proceeders/put_conversation_anchor_atom_proceeder.dart';

import 'operate_strategy.dart';

class PutConversationAnchorStrategy implements OperateStrategy {
  @override
  final Operation operation;
  @override
  final OperateContext context;

  final PortableConversation portable;

  const PutConversationAnchorStrategy({
    required this.context,
    required this.operation,
    required this.portable,
  });

  @override
  Future<void> apply() async {
    final scope = context.scope;
    final proceeder = PutConversationAnchorAtomProceder();
    final atom = await proceeder.apply(context, portable);

    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    await update.write(OperationsCompanion(
      atoms: Value([atom]),
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
