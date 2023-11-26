import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/schema/operation.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class OperationListTile extends StatelessWidget {
  final int id;
  const OperationListTile({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();

    return FutureBuilder(
      future: scope.isar.operations.get(id),
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
