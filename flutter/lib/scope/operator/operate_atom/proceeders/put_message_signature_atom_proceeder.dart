import 'package:drift/drift.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom_type.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/atom_proceeder.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class PutMessageSignatureAtomProceeder implements AtomProceeder<Uint8List> {
  @override
  Future<OperateAtom> apply(Scope scope, Uint8List data) async {
    final select = scope.db.messageSignatures.select();
    select.where((tbl) => tbl.signature.equals(data));
    final record = await select.getSingleOrNull();
    if (record == null) {
      final insert = await scope.db.messageSignatures.insertReturning(
        MessageSignaturesCompanion.insert(signature: data),
      );
      return OperateAtom(
        type: OperateAtomType.putMessageSignature,
        from: null,
        to: insert.id.toString(),
      );
    } else {
      return OperateAtom(
        type: OperateAtomType.putMessageSignature,
        from: record.id.toString(),
        to: record.id.toString(),
      );
    }
  }

  @override
  Future<void> revert(Scope scope, OperateAtom atom) async {
    if (atom.from != null) return;

    final id = int.parse(atom.to);
    await scope.db.messageSignatures.deleteWhere((tbl) => tbl.id.equals(id));
  }
}
