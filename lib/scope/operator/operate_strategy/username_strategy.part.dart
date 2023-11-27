part of 'batch_operate.dart';

class _UsernameStrategy implements _StrategyBase {
  @override
  final Scope scope;
  @override
  final Operation operation;

  _UsernameStrategy({required this.scope, required this.operation});

  @override
  Future<void> apply() async {
    final payloadMap = jsonDecode(operation.payload);
    final currentUsername = scope.snapshot.username;
    final String username = payloadMap['payload']['username'];

    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    await update.write(OperationsCompanion(
      apply: Value(jsonEncode({
        'type': 'account/username',
        'from': currentUsername,
        'to': username,
      })),
    ));

    final snapshot = scope.snapshot.deepCopy()..username = username;
    await scope.handleSetSnapshot(snapshot);
  }

  @override
  Future<void> revert() async {
    final Map applyMap = jsonDecode(operation.apply);
    final username = applyMap['from'];

    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    await update.write(const OperationsCompanion(
      apply: Value(''),
    ));

    final snapshot = scope.snapshot.deepCopy()..username = username;
    await scope.handleSetSnapshot(snapshot);
  }
}
