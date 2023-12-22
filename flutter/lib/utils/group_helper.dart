import 'dart:convert';

import 'package:ENC/dio.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';

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
    final operations = <PortableOperation>[];
    for (final wrapper in wrappers) {
      final operation = await scope.operator.factory.message(wrapper);
      operations.add(operation);
    }
    await scope.operator.apply(operations, isReplay: true);
  }
}
