import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/profile/operations/operation/operation.view.dart';
import 'package:ENC/scope/scope.model.dart';

class OperationsPage extends StatelessWidget {
  const OperationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();
    final select = scope.db.operations.selectOnly()
      ..addColumns([scope.db.operations.id]);
    select.orderBy([
      OrderingTerm.asc(scope.db.operations.clock),
      OrderingTerm.asc(scope.db.operations.clientId),
    ]);
    final stream = select.watch();

    return Scaffold(
      appBar: AppBar(
        title: Text('${scope.secret.signPubKey} / Operations'),
      ),
      body: StreamBuilder<List<TypedResult>>(
        initialData: const [],
        stream: stream,
        builder: (context, snapshot) => ListView.builder(
          itemBuilder: (context, index) => OperationListTile(
            id: snapshot.data![index].read(scope.db.operations.id)!,
          ),
          itemCount: snapshot.data!.length,
        ),
      ),
    );
  }
}
