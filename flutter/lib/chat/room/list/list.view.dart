import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sheason_chat/chat/room/list/list_item/list_item.view.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class MessageListView extends StatefulWidget {
  const MessageListView({super.key});

  @override
  State<StatefulWidget> createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  StreamSubscription? sub;
  var inited = false;
  var initId = 0;

  final itemScrollController = ItemScrollController();
  final scrollOffsetController = ScrollOffsetController();
  final itemPositionListener = ItemPositionsListener.create();
  final scrollOffsetListener = ScrollOffsetListener.create();

  Stream<List<int>> watchData() {
    final scope = context.read<Scope>();
    final conversation = context.read<Conversation>();
    final db = scope.db;
    final select = db.messages.selectOnly();
    select.addColumns([db.messages.id]);
    select.where(db.messages.conversationId.equals(conversation.id));
    select.orderBy([
      OrderingTerm.asc(db.messages.createdAt),
    ]);
    return select
        .watch()
        .map((event) => event.map((e) => e.read(db.messages.id)!).toList());
  }

  Future<void> fetchInitIndex() async {
    final conversation = context.read<Conversation>();
    final scope = context.read<Scope>();
    final db = scope.db;

    final select = db.messageStates.selectOnly().join([
      innerJoin(
        db.messages,
        db.messages.id.equalsExp(db.messageStates.messageId),
      ),
      innerJoin(
        db.contacts,
        db.contacts.id.equalsExp(db.messageStates.contactId),
      ),
    ]);
    select.addColumns([db.messages.id]);
    select.where(Expression.and([
      db.messages.conversationId.equals(conversation.id),
      db.messageStates.checkedAt.isNull(),
      db.contacts.signPubkey.equals(scope.secret.signPubKey),
    ]));
    select.orderBy([
      OrderingTerm.asc(db.messages.createdAt),
    ]);
    select.limit(1);

    final record = await select.getSingleOrNull();
    setState(() {
      initId = record?.read(db.messages.id) ?? 0;
      inited = true;
    });
  }

  @override
  void initState() {
    fetchInitIndex();
    super.initState();
  }

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!inited) return const SizedBox.shrink();

    return StreamBuilder<List<int>>(
      initialData: const [],
      stream: watchData(),
      builder: (context, snapshot) {
        if (snapshot.requireData.isEmpty) return const SizedBox.shrink();

        final messages = snapshot.requireData;
        var initIndex = messages.indexOf(initId) + 1;
        if (initIndex == 0) {
          initIndex = messages.length;
        }
        messages.add(-1);

        return ScrollablePositionedList.builder(
          itemScrollController: itemScrollController,
          scrollOffsetController: scrollOffsetController,
          itemPositionsListener: itemPositionListener,
          scrollOffsetListener: scrollOffsetListener,
          itemCount: messages.length,
          initialScrollIndex: initIndex,
          initialAlignment: 1,
          itemBuilder: (context, index) {
            if (messages[index] == -1) return const SizedBox.shrink();

            return MessageListItemView(
              messageId: messages[index],
            ).padding(vertical: 8, horizontal: 12);
          },
        ).backgroundColor(Colors.black.withOpacity(0.05));
      },
    );
  }
}
