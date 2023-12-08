import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sheason_chat/schema/database.dart';

class OperationDetailPage extends StatelessWidget {
  final Operation operation;
  const OperationDetailPage({
    super.key,
    required this.operation,
  });

  static const jsonEncoder = JsonEncoder.withIndent('  ');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opeartion Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text('Operation Type'),
              subtitle: Text(operation.info.type.name),
            ),
            ListTile(
              title: const Text('Operation Client ID'),
              subtitle: Text(operation.clientId),
            ),
            ListTile(
              title: const Text('Operation Clock'),
              subtitle: Text(operation.clock.toString()),
            ),
            ListTile(
              title: const Text('Operation Content'),
              subtitle: Text(operation.info.content),
            ),
            if (operation.atoms != null)
              if (operation.atoms!.isNotEmpty) ...<Widget>[
                Text(
                  'Operation Atoms',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                for (final atom in operation.atoms!)
                  ListTile(
                    title: Text('Atom ${operation.atoms!.indexOf(atom)}'),
                    subtitle: Text(jsonEncoder.convert({
                      'type': atom.type.name,
                      'from': atom.from,
                      'to': atom.to,
                      'extra': atom.extra,
                    })),
                  ),
              ]
          ],
        ),
      ),
    );
  }
}
