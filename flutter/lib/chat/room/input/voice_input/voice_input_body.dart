import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/input/voice_input/voice_input_overlay.dart';
import 'package:sheason_chat/chat/room/room.controller.dart';
import 'package:sheason_chat/models/network_resource.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

import 'voice_input.controller.dart';

class VoiceInputBody extends StatelessWidget {
  final VoiceInputController controller;
  const VoiceInputBody({
    super.key,
    required this.controller,
  });

  String get hintText {
    if (controller.service.isEmpty) {
      return '无服务';
    } else {
      return controller.service;
    }
  }

  void handlePanStart(BuildContext context, DragStartDetails details) async {
    controller.recording = false;
    if (controller.service.isEmpty) {
      return controller.handleToggleService(context);
    }

    controller.recording = true;

    // build overlay
    final entry = OverlayEntry(
      builder: (context) => VoiceInputOverlay(controller: controller),
    );
    final overlay = Overlay.of(context);
    // start recording
    await controller.startRecord();

    overlay.insert(entry);
    controller.entry = entry;
    controller.cancel = false;
  }

  void handlePanUpdate(BuildContext context, DragUpdateDetails details) {
    if (!controller.recording) return;

    final cancelRect = controller.cancelRect;
    if (cancelRect == null) return;

    final position = details.globalPosition;
    final cancel = cancelRect.contains(position);
    if (controller.cancel != cancel) {
      controller.cancel = cancel;
    }
  }

  void handlePanEnd(BuildContext context, DragEndDetails details) async {
    final scope = context.read<Scope>();
    final chatController = context.read<ChatController>();
    if (!controller.recording) return;

    controller.closeEntry();
    final wavFilePath = await controller.stopRecord();

    if (controller.cancel) {
      await File(wavFilePath!).delete();
      return;
    }

    final resourceUrl = await scope.uploader.upload(
      controller.service,
      wavFilePath!,
    );
    final content = NetworkResource(
      url: resourceUrl,
      name: path.basename(wavFilePath),
    );
    final message = await chatController.createMessage();
    message.messageType = MessageType.MESSAGE_TYPE_AUDIO;
    message.content = jsonEncode(content.toJson());
    await chatController.sendMessage(
      [message],
      toBottom: true,
    );
    // 完成上传后删除文件
    await File(wavFilePath).delete();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onPanStart: (details) => handlePanStart(context, details),
        onPanUpdate: (details) => handlePanUpdate(context, details),
        onPanEnd: (details) => handlePanEnd(context, details),
        child: ListenableBuilder(
          listenable: controller,
          builder: (context, _) => Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.mic),
              Text(hintText).center().padding(left: 8),
            ],
          ),
        )
            .backgroundColor(Colors.black.withOpacity(0.05))
            .clipRRect(all: 8)
            .padding(horizontal: 6),
      ),
    );
  }
}
