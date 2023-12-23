import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/dio.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:ENC/utils/service_selector/service_selector.controller.dart';
import 'package:ENC/utils/service_selector/service_selector.view.dart';
import 'package:ENC/utils/sign_helper.dart';
import 'package:styled_widget/styled_widget.dart';

enum AvatarSubmitTarget {
  snapshot,
  conversation,
}

class AlterAvatarPreviewPage extends StatefulWidget {
  final String imagePath;
  final Conversation? conversation;
  final AvatarSubmitTarget target;

  const AlterAvatarPreviewPage({
    super.key,
    required this.imagePath,
    required this.target,
    required this.conversation,
  });

  @override
  State<StatefulWidget> createState() => _AlterAvatarPreviewPageState();
}

class _AlterAvatarPreviewPageState extends State<AlterAvatarPreviewPage> {
  late final controller = ServiceSelectorController(
    context.read<Scope>(),
  );

  @override
  void dispose() {
    File(widget.imagePath).delete();
    super.dispose();
  }

  void handleSubmit() async {
    final scope = context.read<Scope>();
    final delegate = scope.router.profileDelegate;
    final url = await scope.uploader.upload(
      controller.serviceUrl!,
      widget.imagePath,
    );
    switch (widget.target) {
      case AvatarSubmitTarget.snapshot:
        await handleSubmitSnapshot(url);
        break;
      case AvatarSubmitTarget.conversation:
        await handleSubmitConversation(url);
        break;
    }

    delegate.pages.clear();
    delegate.notify();
  }

  Future<void> handleSubmitSnapshot(String url) async {
    final scope = context.read<Scope>();
    final operation = await scope.operator.factory.avatar(url);
    await scope.operator.apply([operation], isReplay: false);
  }

  Future<void> handleSubmitConversation(String url) async {
    final conversation = widget.conversation;
    if (conversation == null) {
      throw Exception('conversation connot be null');
    }

    final id = conversation.info.agent.signPubKey;

    final scope = context.read<Scope>();

    final wrapper = await SignHelper.wrap(
      scope,
      utf8.encode(jsonEncode({
        'groupId': id,
        'avatarUrl': url,
      })),
      contentType: ContentType.CONTENT_BUFFER,
    );

    await dio.put(
      '${conversation.info.remoteUrl}/group/$id/avatar',
      data: FormData.fromMap({
        'data': base64Encode(wrapper.writeToBuffer()),
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('预览'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ExtendedImage.file(
            File(widget.imagePath),
          ).clipRRect(all: 9999).center(),
          ServiceSelector(controller: controller)
              .width(360)
              .padding(top: 16, bottom: 72),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: handleSubmit,
        icon: const Icon(Icons.check),
        label: const Text('修改头像'),
      ),
    );
  }
}
