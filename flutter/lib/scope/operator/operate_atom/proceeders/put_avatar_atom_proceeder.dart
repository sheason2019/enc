import 'package:protobuf/protobuf.dart';
import 'package:ENC/scope/operator/context.dart';
import 'package:ENC/scope/operator/operate_atom/operate_atom.dart';
import 'package:ENC/scope/operator/operate_atom/operate_atom_type.dart';
import 'package:ENC/scope/operator/operate_atom/proceeders/atom_proceeder.dart';

class PutAvatarAtomProceeder implements AtomProceeder<String> {
  @override
  Future<OperateAtom> apply(OperateContext context, String url) async {
    final scope = context.scope;
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
  Future<void> revert(OperateContext context, OperateAtom atom) async {
    final scope = context.scope;
    final snapshot = scope.snapshot.deepCopy()..avatarUrl = atom.from ?? '';
    await scope.handleSetSnapshot(snapshot);
  }
}
