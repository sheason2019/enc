import 'package:protobuf/protobuf.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom_type.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/atom_proceeder.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class PutUsernameAtomProceeder implements AtomProceeder<String> {
  @override
  Future<OperateAtom> apply(Scope scope, String username) async {
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
  Future<void> revert(Scope scope, OperateAtom atom) async {
    final from = atom.from!;

    final snapshot = scope.snapshot.deepCopy()..username = from;
    await scope.handleSetSnapshot(snapshot);
  }
}
