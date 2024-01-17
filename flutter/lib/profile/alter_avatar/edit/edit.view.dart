import 'package:image/image.dart' as image;
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ENC/profile/alter_avatar/preview/preview.view.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class AlterAvatarEditPage extends StatefulWidget {
  final XFile imageFile;
  final AvatarSubmitTarget target;
  final Conversation? conversation;
  const AlterAvatarEditPage({
    super.key,
    required this.imageFile,
    required this.target,
    this.conversation,
  });

  @override
  State<StatefulWidget> createState() => _AlterAvatarEditPageState();
}

class _AlterAvatarEditPageState extends State<AlterAvatarEditPage> {
  final editorKey = GlobalKey<ExtendedImageEditorState>();

  void handleNext() async {
    final scope = context.read<Scope>();
    final delegate = scope.router.profileDelegate;
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

    delegate.pages.add(
      AlterAvatarPreviewPage(
        image: croped,
        target: widget.target,
        conversation: widget.conversation,
      ),
    );
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('编辑头像'),
      ),
      body: FutureBuilder(
        future: widget.imageFile.readAsBytes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }
          return ExtendedImage.memory(
            snapshot.requireData,
            fit: BoxFit.contain,
            mode: ExtendedImageMode.editor,
            cacheRawData: true,
            extendedImageEditorKey: editorKey,
            initEditorConfigHandler: (state) => EditorConfig(
              cropAspectRatio: CropAspectRatios.ratio1_1,
            ),
          );
        },
      ).padding(all: 48).center(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: handleNext,
        icon: const Icon(Icons.check),
        label: const Text('下一步'),
      ),
    );
  }
}
