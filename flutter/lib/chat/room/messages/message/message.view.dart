import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/messages/checker.controller.dart';
import 'package:sheason_chat/chat/room/messages/message/message_context.model.dart';
import 'package:sheason_chat/chat/room/messages/message/types/audio.view.dart';
import 'package:sheason_chat/chat/room/messages/message/types/file/file.view.dart';
import 'package:sheason_chat/chat/room/messages/message/types/image.view.dart';
import 'package:sheason_chat/chat/room/messages/message/types/rtc.view.dart';
import 'package:sheason_chat/chat/room/messages/message/types/text.view.dart';
import 'package:sheason_chat/chat/room/messages/message/types/video.view.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
      ),
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
        if (!snapshot.hasData) return const SizedBox(height: 70);

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

  Widget contentBuilder(BuildContext context) {
    final message = context.watch<Message>();
    switch (message.messageType) {
      case MessageType.MESSAGE_TYPE_TEXT:
        return const TextMessageView();
      case MessageType.MESSAGE_TYPE_AUDIO:
        return const AudioMessageView();
      case MessageType.MESSAGE_TYPE_VIDEO:
        return const VideoMessageView();
      case MessageType.MESSAGE_TYPE_IMAGE:
        return const ImageMessageView();
      case MessageType.MESSAGE_TYPE_FILE:
        return const FileMessageView();
      case MessageType.MESSAGE_TYPE_RTC:
        return const RtcMessageView();
      default:
        return Text('无法解析的消息类型 ${message.messageType.name}').center();
    }
  }

  Stream<int?> stateStream(BuildContext context) {
    final scope = context.watch<Scope>();
    final message = context.watch<Message>();
    final db = scope.db;

    final select = db.messageStates.selectOnly().join([
      innerJoin(
        db.contacts,
        db.contacts.id.equalsExp(db.messageStates.contactId),
      ),
    ]);
    select.addColumns([db.messageStates.id]);
    select.where(db.contacts.signPubkey.equals(scope.secret.signPubKey));
    select.where(db.messageStates.messageId.equals(message.id));
    return select
        .watchSingleOrNull()
        .map((event) => event?.read(db.messageStates.id));
  }

  @override
  Widget build(BuildContext context) {
    final message = context.watch<Message>();
    return StreamBuilder(
      stream: stateStream(context),
      builder: (context, snapshot) {
        return VisibilityDetector(
          key: ValueKey('message-${message.id}'),
          onVisibilityChanged: !snapshot.hasData
              ? null
              : (info) {
                  if (info.visibleFraction > 0.75) {
                    final checker = context.read<MessageChecker>();
                    checker.check(message);
                  }
                },
          child: contentBuilder(context),
        );
      },
    );
  }
}
