import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/operator/context.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom_type.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/atom_proceeder.dart';

class PutContactAtomProceeder implements AtomProceeder<AccountSnapshot> {
  @override
  Future<OperateAtom?> apply(
    OperateContext context,
    AccountSnapshot snapshot,
  ) async {
    final scope = context.scope;
    final select = scope.db.contacts.select();
    select.where((tbl) => tbl.signPubkey.equals(snapshot.index.signPubKey));
    final exist = await select.getSingleOrNull();
    var id = 0;
    if (exist != null) {
      // update if version bigger
      if (snapshot.version <= exist.snapshot.version) {
        return null;
      }

      final update = scope.db.contacts.update();
      update.where((tbl) => tbl.id.equals(exist.id));
      final contacts = await update.writeReturning(ContactsCompanion(
        snapshot: Value(snapshot),
      ));
      id = contacts.first.id;
    } else {
      // insert
      final contact = await scope.db.contacts.insertReturning(
        ContactsCompanion.insert(
          signPubkey: snapshot.index.signPubKey,
          snapshot: snapshot,
        ),
      );
      id = contact.id;
    }

    return OperateAtom(
      type: OperateAtomType.putContact,
      from: exist == null ? null : base64Encode(exist.snapshot.writeToBuffer()),
      to: '$id',
    );
  }

  @override
  Future<void> revert(OperateContext context, OperateAtom atom) async {
    final scope = context.scope;
    final id = int.parse(atom.to);
    if (atom.from == null) {
      final delete = scope.db.contacts.delete();
      delete.where((tbl) => tbl.id.equals(id));
      await delete.go();
    } else {
      final prevSnapshot = AccountSnapshot.fromBuffer(
        base64Decode(atom.from!),
      );
      final update = scope.db.contacts.update();
      update.where((tbl) => tbl.id.equals(id));
      await update.write(ContactsCompanion(
        snapshot: Value(prevSnapshot),
      ));
    }
  }
}
