import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/scope.model.dart';

extension PortableConversationExtension on PortableConversation {
  AccountIndex findAgent(Scope scope) {
    if (type == ConversationType.CONVERSATION_PRIVATE) {
      // 会话成员数为1时表示为仅对自己发出的消息
      return findPrivateSnapshot(scope).index;
    } else if (type == ConversationType.CONVERSATION_GROUP) {
      // 群组会话直接返回 Conversation 中声明的 Agent
      return agent;
    }
    throw Exception('Unknown conversation type');
  }

  AccountSnapshot findPrivateSnapshot(Scope scope) {
    // 会话成员数为1时表示为仅对自己发出的消息
    if (members.length == 1) {
      final agent = members.first;
      if (agent.index.signPubKey != scope.snapshot.index.signPubKey) {
        throw Exception('Agent sign pubkey not equal to scope snapshot');
      }
      return agent;
    }
    // 会话成员数为2时表示常规的私聊会话
    if (members.length == 2) {
      final agent = members
          .where((e) => e.index.signPubKey != scope.snapshot.index.signPubKey)
          .first;
      return agent;
    }
    throw Exception('invalid member length ${members.length}');
  }
}
