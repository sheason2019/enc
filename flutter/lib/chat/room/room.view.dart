import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/input/file_input/file_input.controller.dart';
import 'package:sheason_chat/chat/room/input/input.view.dart';
import 'package:sheason_chat/chat/room/input/media_input/media_input.controller.dart';
import 'package:sheason_chat/chat/room/list/checker.controller.dart';
import 'package:sheason_chat/chat/room/list/list.view.dart';
import 'package:sheason_chat/chat/room/room.controller.dart';
import 'package:sheason_chat/chat/room/title/title.view.dart';
import 'package:sheason_chat/extensions/conversation/conversation.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class ChatRoomPage extends StatefulWidget {
  final Conversation conversation;
  const ChatRoomPage({super.key, required this.conversation});

  @override
  State<StatefulWidget> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  late final scope = context.read<Scope>();

  handleTriggerAnchor() async {
    // 查询 Anchor 中是否存在此会话，若不存在则创建 Anchor
    final scope = context.read<Scope>();
    final index = scope.anchor.list.indexOf(widget.conversation.id);
    if (index == -1) {
      final portable = await widget.conversation.toPortableConversation(
        scope,
      );
      final operation = await scope.operator.factory.conversationAnchor(
        portable,
      );
      await scope.operator.apply([operation]);
    }
  }

  handleBlockNotifier() {
    scope.notifier.blockConversation = widget.conversation;
    scope.notifier.blockScope = scope;
  }

  handleCancelBlockNotifier() {
    scope.notifier.blockConversation = null;
    scope.notifier.blockScope = null;
  }

  @override
  void initState() {
    handleBlockNotifier();
    handleTriggerAnchor();
    scope.notifier.clean(scope, widget.conversation);
    super.initState();
  }

  @override
  void dispose() {
    handleCancelBlockNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();
    return MultiProvider(
      providers: [
        Provider.value(value: widget.conversation),
        ListenableProvider(
          create: (context) => ChatController(
            scope: scope,
            conversation: widget.conversation,
          ),
          dispose: (context, controller) => controller.dispose(),
        ),
        Provider(
          lazy: false,
          create: (context) => MessageChecker(
            scope: scope,
            conversation: widget.conversation,
            chatController: context.read<ChatController>(),
          ),
        ),
        Provider(
          create: (context) => MediaInputController(context: context),
        ),
        Provider(
          create: (context) => FileInputController(context: context),
        ),
      ],
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: const ChatRoomPageTitle(),
          scrolledUnderElevation: 0,
        ),
        body: Column(
          children: [
            const MessageListView().expanded(),
            const ChatRoomInputView(),
          ],
        ),
      ),
    );
  }
}
