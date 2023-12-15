import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:image/image.dart' as image;
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/profile/alter_avatar/preview/preview.view.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:uuid/uuid.dart';

class AlterAvatarEditPage extends StatefulWidget {
  final XFile imageFile;
  const AlterAvatarEditPage({super.key, required this.imageFile});

  @override
  State<StatefulWidget> createState() => _AlterAvatarEditPageState();
}

class _AlterAvatarEditPageState extends State<AlterAvatarEditPage> {
  final editorKey = GlobalKey<ExtendedImageEditorState>();

  void handleNext() async {
    final scope = context.read<Scope>();
    final delegate = context.read<MainController>().rootDelegate;
    final state = editorKey.currentState;
    if (state == null) return;

    final rect = state.getCropRect()!;
    final src = image.decodeImage(state.rawImageData)!;
    final croped = image.copyCrop(
      src,
      x: rect.left.toInt(),
      y: rect.top.toInt(),
      width: rect.width.toInt(),
      height: rect.height.toInt(),
    );
    final cachePath = path.join(
      scope.paths.cache,
      const Uuid().v4(),
    );
    await image.encodePngFile(cachePath, croped);
    delegate.pages.add(AlterAvatarPreviewPage(imagePath: cachePath));
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('编辑头像'),
      ),
      body: ExtendedImage.file(
        File(widget.imageFile.path),
        fit: BoxFit.contain,
        mode: ExtendedImageMode.editor,
        cacheRawData: true,
        extendedImageEditorKey: editorKey,
        initEditorConfigHandler: (state) => EditorConfig(
          cropAspectRatio: CropAspectRatios.ratio1_1,
        ),
      ).padding(all: 48).center(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: handleNext,
        icon: const Icon(Icons.check),
        label: const Text('下一步'),
      ),
    );
  }
}
