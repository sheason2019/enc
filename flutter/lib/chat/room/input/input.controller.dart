import 'package:sheason_chat/extensions/conversation/conversation.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:uuid/uuid.dart';

class MessageInputController {
  final Scope scope;
  final Conversation conversation;

  MessageInputController({
    required this.scope,
    required this.conversation,
  });

  Future<void> sendMessage({
    required String content,
    required MessageType messageType,
  }) async {
    final portable = PortableMessage();
    portable.messageType = messageType;
    portable.content = content;
    portable.conversation = await conversation.toPortableConversation(scope);
    portable.uuid = const Uuid().v4();
  }
}
