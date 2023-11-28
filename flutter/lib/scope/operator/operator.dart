import 'package:drift/drift.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';

import 'operate_strategy/batch_operate.dart';

class Operator {
  final Scope scope;

  Operator({required this.scope});

  Future<PortableOperation> createOperation(String payload) async {
    final maxClock = scope.db.operations.clock.max();
    final selectCurrentClock = scope.db.operations.selectOnly()
      ..addColumns([maxClock]);
    final record = await selectCurrentClock.getSingleOrNull();
    final currentClock = record?.read(maxClock) ?? 0;
    return PortableOperation()
      ..clientId = scope.deviceId
      ..clock = currentClock + 1
      ..payload = payload;
  }

  Future<void> apply(List<PortableOperation> operations) async {
    await scope.db.transaction(() async {
      // 写入 Operation
      await _write(operations);
      // 查询需要 Revert 的 Operation
      final revertList = await _getRevertList();
      // revert
      await BatchOperate.revert(scope, revertList);
      // 查询未被应用的 Operation
      final applyList = await _getApplyList();
      // 应用所有 Operation
      await BatchOperate.apply(scope, applyList);
    });
    // 请求与服务器进行同步
    for (final subscribe in scope.subscribes.values) {
      subscribe.syncOperation();
    }
  }

  Future<void> _write(List<PortableOperation> operations) async {
    for (final operation in operations) {
      final select = scope.db.operations.select();
      select.where((tbl) => tbl.clientId.equals(operation.clientId));
      select.where((tbl) => tbl.clock.equals(operation.clock));
      final record = await select.getSingleOrNull();
      if (record != null) continue;

      await scope.db.operations.insertReturning(
        OperationsCompanion.insert(
          clientId: operation.clientId,
          clock: operation.clock,
          payload: operation.payload,
          apply: '',
        ),
      );
    }
  }

  Future<List<Operation>> _getRevertList() async {
    // 查询最早未被应用的 Operation
    final select = scope.db.operations.select();
    select.where((tbl) => tbl.apply.equals(''));
    select.orderBy([
      (tbl) => OrderingTerm.asc(tbl.clock),
      (tbl) => OrderingTerm.asc(tbl.clientId),
    ]);
    final operation = await select.getSingle();

    // 查询需要 Revert 的 Operation
    final selectRevert = scope.db.operations.select();
    selectRevert.where(
      (tbl) => Expression.or([
        tbl.clock.isBiggerThanValue(operation.clock),
        tbl.clock.equals(operation.clock) &
            tbl.clientId.isBiggerThanValue(operation.clientId)
      ]),
    );
    selectRevert.where((tbl) => tbl.apply.isNotValue(''));
    selectRevert.orderBy([
      (tbl) => OrderingTerm.desc(tbl.clock),
      (tbl) => OrderingTerm.desc(tbl.clientId),
    ]);
    return selectRevert.get();
  }

  Future<List<Operation>> _getApplyList() async {
    final select = scope.db.operations.select();
    select.where((tbl) => tbl.apply.equals(''));
    select.orderBy([
      (tbl) => OrderingTerm.asc(tbl.clock),
      (tbl) => OrderingTerm.asc(tbl.clientId),
    ]);
    return select.get();
  }
}
