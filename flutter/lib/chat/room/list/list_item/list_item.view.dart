import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/list/list_item/message_context.model.dart';
import 'package:sheason_chat/chat/room/list/list_item/types/text.view.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class MessageListItemView extends StatelessWidget {
  final int messageId;
  const MessageListItemView({super.key, required this.messageId});

  Future<MessageContext> fetchMessage(BuildContext context) async {
    final scope = context.watch<Scope>();
    final select = scope.db.messages.select().join([
      innerJoin(
        scope.db.contacts,
        scope.db.contacts.id.equalsExp(
          scope.db.messages.contactId,
        ),
      )
    ]);
    select.where(scope.db.messages.id.equals(messageId));
    final record = await select.getSingle();
    return MessageContext(
      contact: record.readTable(scope.db.contacts),
      message: record.readTable(scope.db.messages),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchMessage(context),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();

        final messageContext = snapshot.data!;
        return MultiProvider(
          providers: [
            Provider.value(value: messageContext.message),
            Provider.value(value: messageContext.contact),
          ],
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
