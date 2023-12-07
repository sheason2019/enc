import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/room.view.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:sheason_chat/utils/string_helper.dart';
import 'package:styled_widget/styled_widget.dart';

class ConversationAnchorListTile extends StatelessWidget {
  final Conversation conversation;
  const ConversationAnchorListTile({
    super.key,
    required this.conversation,
  });

  void handleClick(
    BuildContext context,
  ) {
    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.add(ChatRoomPage(conversation: conversation));
    delegate.notify();
  }

  Stream<String> conversationName(BuildContext context) {
    final scope = context.watch<Scope>();
    if (conversation.type == ConversationType.CONVERSATION_PRIVATE) {
      final select = scope.db.contacts.select();
      select.where((tbl) => tbl.signPubkey.equals(conversation.signPubkey));
      return select.watchSingle().map((event) => event.snapshot.username);
    }

    throw UnimplementedError();
  }

  Stream<DateTime?> conversationTime(BuildContext context) {
    final scope = context.watch<Scope>();
    final select = scope.db.messages.select();
    select.limit(1);
    select.where((tbl) => tbl.conversationId.equals(conversation.id));
    select.orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]);
    return select.watchSingleOrNull().map((event) => event?.createdAt);
  }

  Stream<String?> messagePreview(BuildContext context) {
    final scope = context.watch<Scope>();
    final select = scope.db.messages.select();
    select.limit(1);
    select.where((tbl) => tbl.conversationId.equals(conversation.id));
    select.orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]);
    return select.watchSingleOrNull().map((event) => event?.content);
  }

  Stream<int> uncheckMessageCount(BuildContext context) {
    final scope = context.watch<Scope>();
    final count = scope.db.messageStates.id.count();
    final select = scope.db.messageStates.selectOnly().join([
      innerJoin(
        scope.db.contacts,
        scope.db.contacts.id.equalsExp(scope.db.messageStates.contactId),
      ),
      innerJoin(
        scope.db.messages,
        scope.db.messages.id.equalsExp(scope.db.messageStates.messageId),
      ),
    ]);
    select.addColumns([count]);
    select.where(scope.db.contacts.signPubkey.equals(scope.secret.signPubKey));
    select.where(scope.db.messageStates.checkedAt.isNull());
    select.where(scope.db.messages.conversationId.equals(conversation.id));
    return select.watchSingle().map((event) => event.read(count)!);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => handleClick(context),
      leading: const CircleAvatar(),
      title: Row(
        children: [
          StreamBuilder(
            initialData: '',
            stream: conversationName(context),
            builder: (context, snapshot) => Text(
              snapshot.requireData,
              overflow: TextOverflow.ellipsis,
            ),
          ).expanded(),
          StreamBuilder(
            stream: conversationTime(context),
            builder: (context, snapshot) => snapshot.hasData
                ? Text(
                    StringHelper.time(snapshot.data!),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          StreamBuilder(
            stream: messagePreview(context),
            builder: (context, snapshot) => snapshot.hasData
                ? Text(
                    snapshot.data!,
                    overflow: TextOverflow.ellipsis,
                  )
                : const SizedBox.shrink(),
          ).expanded(),
          StreamBuilder(
            stream: uncheckMessageCount(context),
            builder: (context, snapshot) => snapshot.hasData
                ? Badge.count(count: snapshot.requireData)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
