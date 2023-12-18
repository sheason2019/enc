import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/scope.model.dart';

extension PortableConversationExtension on PortableConversation {
  AccountIndex findAgent(Scope scope) {
    switch (type) {
      case ConversationType.CONVERSATION_PRIVATE:
        return findPrivateSnapshot(scope).index;
      case ConversationType.CONVERSATION_GROUP:
        return agent;
      default:
        throw UnimplementedError();
    }
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
