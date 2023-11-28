import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class OperationListTile extends StatelessWidget {
  final int id;
  const OperationListTile({super.key, required this.id});

  Future<Operation> fetchOperation(Scope scope) {
    final select = scope.db.operations.select()
      ..where((tbl) => tbl.id.equals(id));
    return select.getSingle();
  }

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();

    return FutureBuilder(
      future: fetchOperation(scope),
      builder: (context, snapshot) {
        var title = '';
        var subtitle = '';

        if (snapshot.hasData) {
          final data = snapshot.data!;
          title = '${data.clientId}/${data.clock}';
          subtitle = data.apply;
        }

        return ListTile(
          title: Text(
            title,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            subtitle,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }
}
