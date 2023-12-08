import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/room.controller.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:styled_widget/styled_widget.dart';

class ChatRoomPageInput extends StatefulWidget {
  const ChatRoomPageInput({super.key});

  @override
  State<StatefulWidget> createState() => _ChatRoomPageInputState();
}

class _ChatRoomPageInputState extends State<ChatRoomPageInput> {
  final inputController = TextEditingController();

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  handleSendMessage() async {
    final controller = context.read<ChatRoomController>();
    final message = await controller.createMessage();
    message.messageType = MessageType.MESSAGE_TYPE_TEXT;
    message.content = inputController.text;
    inputController.clear();

    await controller.sendMessage([message]);
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
          TextField(
            controller: inputController,
            minLines: 1,
            maxLines: 5,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
            ),
          )
              .center()
              .padding(horizontal: 8)
              .backgroundColor(Colors.black.withOpacity(0.05))
              .clipRRect(all: 8)
              .padding(horizontal: 4)
              .expanded(),
          IconButton(
            onPressed: () => handleSendMessage(),
            icon: const Icon(
              Icons.send,
              color: Colors.purple,
            ),
          ),
        ],
      ),
    ).padding(all: 6).border(top: 1, color: Colors.black12);
  }
}
