import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/operation.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class AlterUsernameController extends GetxController {
  final Scope scope;
  AlterUsernameController({required this.scope});

  late final textController = TextEditingController.fromValue(
    TextEditingValue(text: scope.snapshot.value.username),
  );

  Future<void> handleSubmit() async {
    final newName = textController.text;
    final currentClock =
        await scope.isar.operations.where().clockProperty().max() ?? 0;
    final operation = PortableOperation()
      ..clientId = scope.deviceId
      ..clock = currentClock + 1
      ..payload = jsonEncode({
        'type': 'account/username',
        'payload': {
          'username': newName,
        },
      });
    await scope.operator.apply(operation);
    Get.back();
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
