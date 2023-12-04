part of 'batch_operate.dart';

class _PutConversationAnchorStrategy implements _StrategyBase {
  @override
  final Operation operation;
  @override
  final Scope scope;

  const _PutConversationAnchorStrategy({
    required this.operation,
    required this.scope,
  });

  @override
  Future<void> apply() async {
    final Map payloadMap = jsonDecode(operation.payload)['payload'];
    final portableConversation = PortableConversation.fromBuffer(
      base64Decode(payloadMap['conversation']),
    );
    final agent = portableConversation.findAgent(scope);
    final select = scope.db.conversations.select();
    select.where((tbl) => tbl.type.equalsValue(portableConversation.type));
    select.where((tbl) => tbl.signPubkey.equals(agent.signPubKey));
    final conversation = await select.getSingle();

    // 在现有 Anchor 中查找是否存在此字段
    final list = scope.anchor.list.toList();
    final from = list.indexOf(conversation.id);
    if (from != -1) {
      list.removeAt(from);
    }
    list.insert(0, conversation.id);
    final anchorBuilder = scope.anchor.toBuilder()..list.addAll(list);
    final anchor = anchorBuilder.build();
    await scope.handleSetConversationAnchor(anchor);

    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    await update.write(OperationsCompanion(
      apply: Value(jsonEncode({
        'from': from,
        'conversationId': conversation.id,
      })),
    ));
  }

  @override
  Future<void> revert() async {
    final Map applyMap = jsonDecode(operation.apply);
    final list = scope.anchor.list.toList();
    final int conversationId = applyMap['conversationId'];
    final int from = applyMap['from'];

    list.removeWhere((e) => e == conversationId);
    if (from != -1) {
      list.insert(from, conversationId);
    }

    final anchorBuilder = scope.anchor.toBuilder()..list.addAll(list);
    final anchor = anchorBuilder.build();
    await scope.handleSetConversationAnchor(anchor);

    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    await update.write(const OperationsCompanion(
      apply: Value(''),
    ));
  }
}
