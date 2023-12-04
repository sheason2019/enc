import 'package:flutter/material.dart';
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

  handleSendMessage() {
    debugPrint('handle send message ${inputController.text}');
    inputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
            .constrained(minHeight: 38)
            .padding(horizontal: 8)
            .backgroundColor(Colors.black.withOpacity(0.05))
            .center()
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
    ).padding(all: 6).border(top: 1, color: Colors.black12);
  }
}
