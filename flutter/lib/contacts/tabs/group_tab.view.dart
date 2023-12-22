import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/chat/anchors/anchor/anchor.view.dart';
import 'package:ENC/chat/room/room.view.dart';
import 'package:ENC/main.controller.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';

class GroupsTab extends StatelessWidget {
  const GroupsTab({super.key});

  Stream<List<int>> fetchStream(BuildContext context) {
    final scope = context.watch<Scope>();
    final select = scope.db.conversations.selectOnly();
    select.addColumns([scope.db.conversations.id]);
    select.where(
      scope.db.conversations.type.equalsValue(
        ConversationType.CONVERSATION_GROUP,
      ),
    );
    return select
        .watch()
        .map((e) => e.map((e) => e.read(scope.db.conversations.id)!))
        .map((e) => e.toList());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: const [],
      stream: fetchStream(context),
      builder: (context, snapshot) {
        final ids = snapshot.data ?? [];

        return ListView.builder(
          itemCount: ids.length,
          itemBuilder: (context, index) => GroupListTile(id: ids[index]),
        );
      },
    );
  }
}

class GroupListTile extends StatelessWidget {
  final int id;
  const GroupListTile({super.key, required this.id});

  Future<Conversation> findGroup(BuildContext context) {
    final scope = context.watch<Scope>();
    final select = scope.db.conversations.select();
    select.where((tbl) => tbl.id.equals(id));
    return select.getSingle();
  }

  void toConversation(
    BuildContext context,
    Conversation conversation,
  ) {
    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.add(ChatRoomPage(conversation: conversation));
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: findGroup(context),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        return ListTile(
          onTap: () => toConversation(context, snapshot.requireData),
          leading: ConversationAvatar(conversation: snapshot.requireData),
          title: Text(snapshot.requireData.info.name),
          subtitle: Text(snapshot.requireData.signPubkey),
        );
      },
    );
  }
}
