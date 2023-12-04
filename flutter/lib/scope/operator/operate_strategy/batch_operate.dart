import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:protobuf/protobuf.dart';
import 'package:sheason_chat/extensions/portable_conversation/portable_conversation.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';

part 'base.part.dart';
part 'put_service_strategy.part.dart';
part 'username_strategy.part.dart';
part 'put_contact_strategy.part.dart';
part 'put_conversation_strategy.dart';
part 'put_conversation_anchor.part.dart';

class BatchOperate {
  BatchOperate._();

  static Future<void> revert(
    Scope scope,
    List<Operation> operations,
  ) async {
    for (final operation in operations) {
      final strategy = _StrategyBase.create(scope, operation);
      await strategy.revert();
    }
  }

  static Future<void> apply(
    Scope scope,
    List<Operation> operations,
  ) async {
    for (final operation in operations) {
      final strategy = _StrategyBase.create(scope, operation);
      await strategy.apply();
    }
  }
}
