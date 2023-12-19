import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/operator/context.dart';

import 'operate_strategy/operate_strategy.dart';

class BatchOperate {
  BatchOperate._();

  static Future<void> revert(
    OperateContext context,
    List<Operation> operations,
  ) async {
    for (final operation in operations) {
      final strategy = OperateStrategy.create(context, operation);
      await strategy.revert();
    }
  }

  static Future<void> apply(
    OperateContext context,
    List<Operation> operations,
  ) async {
    for (final operation in operations) {
      final strategy = OperateStrategy.create(
        context,
        operation,
      );
      await strategy.apply();
    }
  }
}
