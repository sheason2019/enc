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
      // 1. Strategy 根据 Operation 的 type 和 content 生成 Atom
      // 2. 调用 Atom Proceeder 应用 Atom，完成对数据库的写入操作
      // 3. 修改 Operation 中的 atoms 字段，完成 Apply 操作
      final strategy = OperateStrategy.create(scope, operation);
      await strategy.apply();
    }
  }
}
