import 'dart:convert';

import 'package:sheason_chat/dio.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class GroupHelper {
  GroupHelper._();

  static Future<void> pullMessage(
    Scope scope,
    Conversation conversation,
  ) async {
    if (conversation.type != ConversationType.CONVERSATION_GROUP) {
      throw UnimplementedError();
    }

    final url = conversation.info.remoteUrl;
    final agent = conversation.info.agent;

    // 这里先全量拉取，等到有性能问题再进行优化
    final resp = await dio.get('$url/group/${agent.signPubKey}/message');
    final wrappers = (resp.data as List)
        .map((e) => base64Decode(e))
        .map((e) => SignWrapper.fromBuffer(e));
    var i = 0;
    final operations = <PortableOperation>[];
    for (final wrapper in wrappers) {
      final operation = await scope.operator.factory.message(
        wrapper,
        offset: i++,
      );
      operations.add(operation);
    }
    await scope.operator.apply(operations, isReplay: true);
  }
}
