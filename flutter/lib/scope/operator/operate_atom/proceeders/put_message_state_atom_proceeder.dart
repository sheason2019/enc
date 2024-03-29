import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:fixnum/fixnum.dart';
import 'package:ENC/extensions/int64/int64.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/operator/context.dart';
import 'package:ENC/scope/operator/operate_atom/operate_atom.dart';
import 'package:ENC/scope/operator/operate_atom/operate_atom_type.dart';
import 'package:ENC/scope/operator/operate_atom/proceeders/atom_proceeder.dart';

class PutMessageStateAtomProceeder
    implements AtomProceeder<PortableMessageState> {
  final Message? message;

  PutMessageStateAtomProceeder({
    required this.message,
  });

  @override
  Future<OperateAtom> apply(
    OperateContext context,
    PortableMessageState portable,
  ) async {
    final scope = context.scope;
    final message = this.message!;

    final selectStateContact = scope.db.contacts.select();
    selectStateContact.where(
      (tbl) => tbl.signPubkey.equals(portable.accountIndex.signPubKey),
    );
    final stateContact = await selectStateContact.getSingle();

    final select = scope.db.messageStates.select();
    select.where((tbl) => tbl.messageId.equals(message.id));
    select.where((tbl) => tbl.contactId.equals(stateContact.id));
    final messageState = await select.getSingleOrNull();
    if (messageState == null) {
      final insert = await scope.db.messageStates.insertReturning(
        MessageStatesCompanion.insert(
          contactId: stateContact.id,
          messageId: message.id,
          createdAt: Value(portable.createdAt.toDatetime()),
          receiveAt: Value(portable.receiveAt.toDatetime()),
          checkedAt: Value(portable.checkedAt.toDatetime()),
        ),
      );
      return OperateAtom(
        type: OperateAtomType.putMessageState,
        from: null,
        to: insert.id.toString(),
      );
    } else {
      final update = scope.db.messageStates.update();
      update.where((tbl) => tbl.id.equals(messageState.id));
      await update.write(MessageStatesCompanion(
        createdAt: Value(portable.createdAt.toDatetime()),
        receiveAt: Value(portable.receiveAt.toDatetime()),
        checkedAt: Value(portable.checkedAt.toDatetime()),
      ));
      final prevPortable = PortableMessageState();
      prevPortable.accountIndex = stateContact.snapshot.index;
      prevPortable.createdAt = Int64(
        messageState.createdAt?.millisecondsSinceEpoch ?? 0,
      );
      prevPortable.receiveAt = Int64(
        messageState.receiveAt?.millisecondsSinceEpoch ?? 0,
      );
      prevPortable.checkedAt = Int64(
        messageState.checkedAt?.millisecondsSinceEpoch ?? 0,
      );
      return OperateAtom(
        type: OperateAtomType.putMessageState,
        from: base64Encode(prevPortable.writeToBuffer()),
        to: messageState.id.toString(),
      );
    }
  }

  @override
  Future<void> revert(OperateContext context, OperateAtom atom) async {
    final scope = context.scope;
    final int id = int.parse(atom.to);
    if (atom.from == null) {
      await scope.db.messageStates.deleteWhere((tbl) => tbl.id.equals(id));
    } else {
      final prevPortale = PortableMessageState.fromBuffer(
        base64Decode(atom.from!),
      );
      final update = scope.db.messageStates.update();
      update.where((tbl) => tbl.id.equals(id));
      await update.write(MessageStatesCompanion(
        createdAt: Value(prevPortale.createdAt.toDatetime()),
        receiveAt: Value(prevPortale.receiveAt.toDatetime()),
        checkedAt: Value(prevPortale.checkedAt.toDatetime()),
      ));
    }
  }
}
