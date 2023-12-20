import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/conversation_setting/conversation_setting.view.dart';
import 'package:sheason_chat/chat/room/input/file_input/file_input.controller.dart';
import 'package:sheason_chat/chat/room/input/input.view.dart';
import 'package:sheason_chat/chat/room/input/media_input/media_input.controller.dart';
import 'package:sheason_chat/chat/room/messages/checker.controller.dart';
import 'package:sheason_chat/chat/room/messages_panel/messages_panel.view.dart';
import 'package:sheason_chat/chat/room/room.controller.dart';
import 'package:sheason_chat/chat/room/title/title.view.dart';
import 'package:sheason_chat/main.controller.dart';
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

  Stream<Conversation> createStream() {
    final scope = context.read<Scope>();
    final select = scope.db.conversations.select();
    select.where((tbl) => tbl.id.equals(widget.conversation.id));
    return select.watchSingle();
  }

  handleTriggerAnchor() async {
    // 查询 Anchor 中是否存在此会话，若不存在则创建 Anchor
    final scope = context.read<Scope>();
    final index = scope.anchor.list.indexOf(widget.conversation.id);
    if (index == -1) {
      final portable = widget.conversation.info;
      final operation = await scope.operator.factory.conversationAnchor(
        portable,
      );
      await scope.operator.apply([operation], isReplay: false);
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

  toSettings(BuildContext context) {
    final conversation = context.read<Conversation>();
    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.add(
      ConversationSettingPage(conversation: conversation),
    );
    delegate.notify();
  }

  @override
  void dispose() {
    handleCancelBlockNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Conversation>(
      initialData: widget.conversation,
      stream: createStream(),
      builder: (context, snapshot) => MultiProvider(
        providers: [
          Provider.value(value: snapshot.requireData),
          Provider(
            create: (context) => ChatController(context: context),
            dispose: (context, controller) => controller.dispose(),
          ),
          Provider(
            lazy: false,
            create: (context) => MessageChecker(context: context),
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
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  onPressed: () => toSettings(context),
                  icon: const Icon(Icons.menu),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              const MessagesPanelView().expanded(),
              const ChatRoomInputView(),
            ],
          ),
        ),
      ),
    );
  }
}
