part of 'batch_operate.dart';

abstract class _StrategyBase {
  Scope get scope;
  Operation get operation;

  Future<void> apply();
  Future<void> revert();

  factory _StrategyBase.create(Scope scope, Operation operation) {
    final Map map = jsonDecode(operation.payload);
    switch (map['type']) {
      case 'account/username':
        return _UsernameStrategy(scope: scope, operation: operation);
      default:
        throw UnimplementedError('Unknown strategy type: ${map['type']}');
    }
  }
}
