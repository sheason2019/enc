import 'package:drift/drift.dart';
import 'package:sheason_chat/extensions/portable_conversation/portable_conversation.dart';
import 'package:sheason_chat/models/conversation_anchor.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/operator/context.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom_type.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/atom_proceeder.dart';

class PutConversationAnchorAtomProceder
    implements AtomProceeder<PortableConversation> {
  @override
  Future<OperateAtom> apply(
    OperateContext context,
    PortableConversation portableConversation,
  ) async {
    final scope = context.scope;
    final agent = portableConversation.findAgent(scope);
    final select = scope.db.conversations.select();
    select.where((tbl) => tbl.type.equalsValue(portableConversation.type));
    select.where((tbl) => tbl.signPubkey.equals(agent.signPubKey));
    final conversation = await select.getSingle();

    // 在现有 Anchor 中查找是否存在此字段
    final list = scope.anchor.list.toList();
    final from = list.indexOf(conversation.id);
    list.removeWhere((element) => element == conversation.id);
    list.insert(0, conversation.id);

    final anchor = ConversationAnchor(list: list);
    scope.handleSetConversationAnchor(anchor);

    return OperateAtom(
      type: OperateAtomType.putConversationAnchor,
      from: from.toString(),
      to: '',
      extra: {
        'conversationId': conversation.id,
      },
    );
  }

  @override
  Future<void> revert(OperateContext context, OperateAtom atom) async {
    final scope = context.scope;
    final conversationId = atom.extra!['conversationId'];
    final list = scope.anchor.list.toList();
    list.remove(conversationId);
    if (atom.from != null) {
      final from = int.parse(atom.from!);
      if (from != -1) list.insert(from, from);
    }

    await scope.handleSetConversationAnchor(
      ConversationAnchor(list: list),
    );
  }
}
