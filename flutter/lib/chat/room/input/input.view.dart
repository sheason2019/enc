import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/chat/room/input/text_input.view.dart';
import 'package:ENC/chat/room/input/voice_input/voice_input.view.dart';
import 'package:ENC/chat/room/room.controller.dart';

class ChatRoomInputView extends StatelessWidget {
  const ChatRoomInputView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ChatController>();
    final inputController = controller.inputController;
    return ListenableBuilder(
      listenable: inputController,
      builder: (context, _) {
        if (inputController.useTextInput) {
          return const TextInputView();
        } else {
          return const VoiceInputView();
        }
      },
    );
  }
}
