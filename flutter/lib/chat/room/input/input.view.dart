import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/input/text_input.view.dart';
import 'package:sheason_chat/chat/room/input/voice_input/voice_input.view.dart';
import 'package:sheason_chat/chat/room/room.controller.dart';

class ChatRoomInputView extends StatelessWidget {
  const ChatRoomInputView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ChatController>();
    if (controller.useTextInput) {
      return const TextInputView();
    } else {
      return const VoiceInputView();
    }
  }
}
