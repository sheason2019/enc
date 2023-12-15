import 'package:drift/drift.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom_type.dart';
import 'package:sheason_chat/scope/scope.model.dart';

import 'atom_proceeder.dart';

class PutMessageAtomProceeder implements AtomProceeder<PortableMessage> {
  final Contact? contact;
  final Conversation? conversation;

  PutMessageAtomProceeder({
    required this.contact,
    required this.conversation,
  });

  @override
  Future<OperateAtom?> apply(
    Scope scope,
    PortableMessage portableMessage,
  ) async {
    final db = scope.db;
    final contact = this.contact!;
    final conversation = this.conversation!;

    final selectMessage = db.messages.select();
    selectMessage.where((tbl) => tbl.contactId.equals(contact.id));
    selectMessage.where((tbl) => tbl.conversationId.equals(conversation.id));
    selectMessage.where((tbl) => tbl.uuid.equals(portableMessage.uuid));
    final message = await selectMessage.getSingleOrNull();

    if (message != null) {
      // 若消息已存在，则不进行任何操作
      return null;
    }

    final insert = await db.messages.insertReturning(MessagesCompanion.insert(
      conversationId: conversation.id,
      contactId: contact.id,
      uuid: portableMessage.uuid,
      content: portableMessage.content,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        portableMessage.createdAt.toInt(),
      ),
      messageType: portableMessage.messageType,
    ));

    return OperateAtom(
      type: OperateAtomType.putMessage,
      from: null,
      to: insert.id.toString(),
    );
  }

  @override
  Future<void> revert(Scope scope, OperateAtom atom) async {
    if (atom.from != null) return;

    final id = int.parse(atom.to);
    await scope.db.messages.deleteWhere((tbl) => tbl.id.equals(id));
  }
}
