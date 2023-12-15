import 'package:protobuf/protobuf.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom_type.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/atom_proceeder.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class PutAvatarAtomProceeder implements AtomProceeder<String> {
  @override
  Future<OperateAtom> apply(Scope scope, String url) async {
    final currentAvatar = scope.snapshot.avatarUrl;
    final snapshot = scope.snapshot.deepCopy()..avatarUrl = url;
    await scope.handleSetSnapshot(snapshot);

    return OperateAtom(
      type: OperateAtomType.putAvatar,
      from: currentAvatar,
      to: url,
    );
  }

  @override
  Future<void> revert(Scope scope, OperateAtom atom) async {
    final snapshot = scope.snapshot.deepCopy()..avatarUrl = atom.from ?? '';
    await scope.handleSetSnapshot(snapshot);
  }
}
