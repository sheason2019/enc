import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/list/list_item/list_item.view.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class MessageListView extends StatelessWidget {
  const MessageListView({super.key});

  Stream<List<int>> messageStream(BuildContext context) {
    final scope = context.watch<Scope>();
    final conversation = context.watch<Conversation>();
    final db = scope.db;
    final select = db.messages.selectOnly();
    select.addColumns([db.messages.id]);
    select.where(db.messages.conversationId.equals(conversation.id));
    return select
        .watch()
        .map((event) => event.map((e) => e.read(db.messages.id)!).toList());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: const [],
      stream: messageStream(context),
      builder: (context, snapshot) => ListView.builder(
        itemCount: snapshot.requireData.length,
        itemBuilder: (context, index) => MessageListItemView(
          messageId: snapshot.requireData[index],
        ).padding(vertical: 4),
      ),
    ).padding(horizontal: 12).backgroundColor(Colors.black.withOpacity(0.05));
  }
}
