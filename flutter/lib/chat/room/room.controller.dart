import 'package:sheason_chat/chat/room/input/input.controller.dart';
import 'package:sheason_chat/chat/room/messages/messages.controller.dart';
import 'package:sheason_chat/chat/room/uncheck_message_hint/uncheck_message_hint.controller.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class ChatController {
  final Scope scope;
  final Conversation conversation;

  late final messagesController = MessagesController(
    scope: scope,
    conversation: conversation,
  );
  late final uncheckController = UncheckMessageHintController(
    scope: scope,
    conversation: conversation,
  );
  late final inputController = MessageInputController(
    scope: scope,
    conversation: conversation,
  );

  ChatController({
    required this.scope,
    required this.conversation,
  });

  void dispose() {
    messagesController.dispose();
    uncheckController.dispose();
    inputController.dispose();
  }
}
