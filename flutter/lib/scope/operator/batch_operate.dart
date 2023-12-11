import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';

import 'operate_strategy/operate_strategy.dart';

class BatchOperate {
  BatchOperate._();

  static Future<void> revert(
    Scope scope,
    List<Operation> operations,
  ) async {
    for (final operation in operations) {
      final strategy = OperateStrategy.create(scope, operation);
      await strategy.revert();
    }
  }

  static Future<void> apply(
    Scope scope,
    List<Operation> operations,
  ) async {
    for (final operation in operations) {
      final strategy = OperateStrategy.create(scope, operation);
      await strategy.apply();
    }
  }
}
