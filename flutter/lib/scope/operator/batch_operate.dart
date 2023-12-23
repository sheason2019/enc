import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/operator/context.dart';
import 'package:flutter/material.dart';

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
      debugPrint('revert clock ${operation.clock}');
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
      debugPrint('apply clock ${operation.clock}');
    }
  }
}
