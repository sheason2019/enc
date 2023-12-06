import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom_type.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/atom_proceeder.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class PutContactAtomProceeder implements AtomProceeder<AccountSnapshot> {
  @override
  Future<OperateAtom> apply(Scope scope, AccountSnapshot snapshot) async {
    final select = scope.db.contacts.select();
    select.where((tbl) => tbl.signPubkey.equals(snapshot.index.signPubKey));
    final exist = await select.getSingleOrNull();
    if (exist != null) {
      // update
      final update = scope.db.contacts.update();
      update.where((tbl) => tbl.id.equals(exist.id));
      await update.write(ContactsCompanion(
        snapshot: Value(snapshot),
      ));
    } else {
      // insert
      await scope.db.contacts.insertReturning(
        ContactsCompanion.insert(
          signPubkey: snapshot.index.signPubKey,
          snapshot: snapshot,
        ),
      );
    }

    return OperateAtom(
      type: OperateAtomType.putContact,
      from: exist == null ? null : base64Encode(exist.snapshot.writeToBuffer()),
      to: base64Encode(snapshot.writeToBuffer()),
    );
  }

  @override
  Future<void> revert(Scope scope, OperateAtom atom) async {
    final snapshot = AccountSnapshot.fromBuffer(base64Decode(atom.to));
    if (atom.from == null) {
      final delete = scope.db.contacts.delete();
      delete.where((tbl) => tbl.signPubkey.equals(snapshot.index.signPubKey));
      await delete.go();
    } else {
      final prevSnapshot = AccountSnapshot.fromBuffer(
        base64Decode(atom.from!),
      );
      final update = scope.db.contacts.update();
      update.where((tbl) => tbl.signPubkey.equals(snapshot.index.signPubKey));
      await update.write(ContactsCompanion(
        snapshot: Value(prevSnapshot),
      ));
    }
  }
}
