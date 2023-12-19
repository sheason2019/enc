import 'package:protobuf/protobuf.dart';
import 'package:sheason_chat/scope/operator/context.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom_type.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/atom_proceeder.dart';

class PutUsernameAtomProceeder implements AtomProceeder<String> {
  @override
  Future<OperateAtom> apply(OperateContext context, String username) async {
    final scope = context.scope;
    final currentUsername = scope.snapshot.username;

    final snapshot = scope.snapshot.deepCopy()..username = username;
    await scope.handleSetSnapshot(snapshot);

    return OperateAtom(
      type: OperateAtomType.putUsername,
      from: currentUsername,
      to: username,
    );
  }

  @override
  Future<void> revert(OperateContext context, OperateAtom atom) async {
    final scope = context.scope;
    final from = atom.from!;

    final snapshot = scope.snapshot.deepCopy()..username = from;
    await scope.handleSetSnapshot(snapshot);
  }
}
