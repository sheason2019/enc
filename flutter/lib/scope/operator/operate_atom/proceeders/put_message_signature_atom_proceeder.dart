import 'package:drift/drift.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/operator/context.dart';
import 'package:ENC/scope/operator/operate_atom/operate_atom.dart';
import 'package:ENC/scope/operator/operate_atom/operate_atom_type.dart';
import 'package:ENC/scope/operator/operate_atom/proceeders/atom_proceeder.dart';

class PutMessageSignatureAtomProceeder implements AtomProceeder<Uint8List> {
  @override
  Future<OperateAtom?> apply(OperateContext context, Uint8List data) async {
    final scope = context.scope;
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
      return null;
    }
  }

  @override
  Future<void> revert(OperateContext context, OperateAtom atom) async {
    final scope = context.scope;
    if (atom.from != null) return;

    final id = int.parse(atom.to);
    await scope.db.messageSignatures.deleteWhere((tbl) => tbl.id.equals(id));
  }
}
