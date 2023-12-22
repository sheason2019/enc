import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/chat/room/input/input.controller.dart';
import 'package:ENC/chat/room/messages/messages.controller.dart';
import 'package:ENC/chat/room/uncheck_message_hint/uncheck_message_hint.controller.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';

class ChatController {
  BuildContext context;

  Scope get scope => context.read<Scope>();
  Conversation get conversation => context.read<Conversation>();

  late final messagesController = MessagesController(context: context);
  late final uncheckController = UncheckMessageHintController(
    context: context,
  );
  late final inputController = MessageInputController(
    context: context,
  );

  ChatController({required this.context});

  void dispose() {
    messagesController.dispose();
    uncheckController.dispose();
    inputController.dispose();
  }
}
