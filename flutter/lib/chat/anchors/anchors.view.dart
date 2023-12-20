import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/anchors/anchor/anchor.view.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class ConversationAnchorsView extends StatelessWidget {
  const ConversationAnchorsView({super.key});

  Stream<Conversation> fetchConversation(
    BuildContext context,
    int id,
  ) {
    final scope = context.watch<Scope>();
    final select = scope.db.conversations.select();
    select.where((tbl) => tbl.id.equals(id));
    return select.watchSingle();
  }

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();
    final list = scope.anchor.list;
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => StreamBuilder(
        stream: fetchConversation(context, list[index]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }

          return ConversationAnchorListTile(
            conversation: snapshot.requireData,
          );
        },
      ),
    );
  }
}
