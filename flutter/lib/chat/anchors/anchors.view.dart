import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/anchors/anchor/anchor.view.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class ConversationAnchorsView extends StatelessWidget {
  const ConversationAnchorsView({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();
    final list = scope.anchor.list;
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => ConversationAnchorListTile(
        conversationid: list[index],
      ),
    );
  }
}
