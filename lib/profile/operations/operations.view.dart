import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:sheason_chat/profile/operations/operation/operation.view.dart';
import 'package:sheason_chat/schema/operation.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class OperationsPage extends StatelessWidget {
  const OperationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = Get.find<Scope>();

    return Scaffold(
      appBar: AppBar(
        title: Text('${scope.secret.value.signPubKey} / Operations'),
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: scope.isar.operations
            .where()
            .idProperty()
            .watch(fireImmediately: true),
        builder: (context, snapshot) => ListView.builder(
          itemBuilder: (context, index) => OperationListTile(
            id: snapshot.data![index],
          ),
          itemCount: snapshot.data!.length,
        ),
      ),
    );
  }
}
