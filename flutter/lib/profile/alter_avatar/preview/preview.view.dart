import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:sheason_chat/utils/service_selector/service_selector.controller.dart';
import 'package:sheason_chat/utils/service_selector/service_selector.view.dart';
import 'package:styled_widget/styled_widget.dart';

class AlterAvatarPreviewPage extends StatefulWidget {
  final String imagePath;
  const AlterAvatarPreviewPage({
    super.key,
    required this.imagePath,
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
    final delegate = context.read<MainController>().rootDelegate;
    final scope = context.read<Scope>();
    final url = await scope.uploader.upload(
      controller.serviceUrl!,
      widget.imagePath,
    );
    final operation = await scope.operator.factory.avatar(url);
    await scope.operator.apply([operation]);
    delegate.pages.removeLast();
    delegate.pages.removeLast();
    delegate.notify();
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
