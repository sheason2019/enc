import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/dio.dart';
import 'package:ENC/prototypes/core.pbenum.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:ENC/utils/sign_helper.dart';
import 'package:styled_widget/styled_widget.dart';

class AlterGroupNamePage extends StatefulWidget {
  final Conversation conversation;
  const AlterGroupNamePage({super.key, required this.conversation});

  @override
  State<StatefulWidget> createState() => _AlterGroupNamePageState();
}

class _AlterGroupNamePageState extends State<AlterGroupNamePage> {
  late final controller = TextEditingController(
    text: widget.conversation.info.name,
  );

  void handleSubmit() async {
    final delegate = context.read<Scope>().router.chatDelegate;
    final conversation = widget.conversation;
    final id = conversation.info.agent.signPubKey;
    final scope = context.read<Scope>();
    final wrapper = await SignHelper.wrap(
      scope,
      utf8.encode(jsonEncode({
        'groupId': id,
        'name': controller.text,
      })),
      contentType: ContentType.CONTENT_BUFFER,
    );

    await dio.put(
      '${conversation.info.remoteUrl}/group/$id/name',
      data: FormData.fromMap({
        'data': base64Encode(wrapper.writeToBuffer()),
      }),
    );

    delegate.pages.removeLast();
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('编辑群聊名称'),
      ),
      body: TextField(
        controller: controller,
        decoration: const InputDecoration(
          label: Text('新的群聊名称'),
        ),
      ).width(360).center(),
      floatingActionButton: FloatingActionButton(
        onPressed: handleSubmit,
        child: const Icon(Icons.check),
      ),
    );
  }
}
