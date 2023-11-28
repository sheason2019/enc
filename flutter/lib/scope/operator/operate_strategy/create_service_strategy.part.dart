part of 'batch_operate.dart';

class _CreateServiceStrategy implements _StrategyBase {
  @override
  final Operation operation;
  @override
  final Scope scope;

  _CreateServiceStrategy({required this.operation, required this.scope});

  @override
  Future<void> apply() async {
    final Map payload = jsonDecode(operation.payload)['payload'];
    final String url = payload['url'];
    final service = PortableService.fromBuffer(
      base64Decode(payload['service']),
    );
    final prevService = scope.snapshot.serviceMap[url];
    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    await update.write(OperationsCompanion(
      apply: Value(jsonEncode({
        'url': url,
        'from': prevService == null
            ? null
            : base64Encode(prevService.writeToBuffer()),
        'to': base64Encode(service.writeToBuffer()),
      })),
    ));
    final snapshot = scope.snapshot.deepCopy()..serviceMap[url] = service;
    await scope.handleSetSnapshot(snapshot);
  }

  @override
  Future<void> revert() async {
    final Map applyMap = jsonDecode(operation.apply);
    final String url = applyMap['url'];
    final String? prevService = applyMap['from'];

    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    await update.write(const OperationsCompanion(
      apply: Value(''),
    ));

    final snapshot = scope.snapshot.deepCopy();
    if (prevService == null) {
      snapshot.serviceMap.remove(url);
    } else {
      snapshot.serviceMap[url] = PortableService.fromBuffer(
        base64Decode(prevService),
      );
    }
    await scope.handleSetSnapshot(snapshot);
  }
}
