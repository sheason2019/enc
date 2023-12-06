import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/list/list_item/types/text.view.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class MessageListItemView extends StatelessWidget {
  final int messageId;
  const MessageListItemView({super.key, required this.messageId});

  Future<Message> fetchMessage(BuildContext context) {
    final scope = context.watch<Scope>();
    final select = scope.db.messages.select();
    select.where((tbl) => tbl.id.equals(messageId));
    return select.getSingle();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchMessage(context),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();

        return Provider.value(
          value: snapshot.data!,
          builder: (context, _) => const _MessageItemRenderer(),
        );
      },
    );
  }
}

class _MessageItemRenderer extends StatelessWidget {
  const _MessageItemRenderer();

  @override
  Widget build(BuildContext context) {
    final message = context.watch<Message>();
    switch (message.messageType) {
      case MessageType.MESSAGE_TYPE_TEXT:
        return const TextMessageView();
      default:
        return Container();
    }
  }
}
