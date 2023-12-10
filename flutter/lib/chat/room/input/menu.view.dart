import 'dart:convert';

import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/input/file_input/file_input.controller.dart';
import 'package:sheason_chat/chat/room/input/media_input/media_input.controller.dart';
import 'package:sheason_chat/chat/room/room.controller.dart';
import 'package:sheason_chat/models/network_resource.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class InputMenuIconButton extends StatelessWidget {
  const InputMenuIconButton({super.key});

  void handleClick(BuildContext context) {
    final chatController = context.read<ChatController>();
    final mediaInputController = context.read<MediaInputController>();
    final fileInputController = context.read<FileInputController>();
    showModalBottomSheet(
      context: context,
      builder: (context) => InputMenuBottomSheet(
        scope: context.read<Scope>(),
        chatController: chatController,
        mediaInputController: mediaInputController,
        fileInputController: fileInputController,
      ).height(160),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => handleClick(context),
      icon: const Icon(Icons.menu),
    );
  }
}

class InputMenuBottomSheet extends StatelessWidget {
  final ChatController chatController;
  final MediaInputController mediaInputController;
  final FileInputController fileInputController;
  final Scope scope;
  const InputMenuBottomSheet({
    super.key,
    required this.chatController,
    required this.mediaInputController,
    required this.fileInputController,
    required this.scope,
  });

  handleCloseSheet(BuildContext context) {
    Navigator.of(context).pop();
  }

  handleToogleVoiceInput(BuildContext context) {
    chatController.useTextInput = false;
    handleCloseSheet(context);
  }

  handleToggleTextInput(BuildContext context) {
    chatController.useTextInput = true;
    handleCloseSheet(context);
  }

  handleInputMedia(BuildContext context) async {
    handleCloseSheet(context);

    final mediaInputContext = await mediaInputController.pickMedia();
    if (mediaInputContext == null) return;

    final serviceUrl = await mediaInputController.showPreviewDialog(
      mediaInputContext,
    );
    if (serviceUrl == null) return;

    final upload = await scope.uploader.upload(
      serviceUrl,
      mediaInputContext.mediaFile.path,
    );

    final message = await chatController.createMessage();
    switch (mediaInputContext.mediaType) {
      case MediaType.image:
        message.messageType = MessageType.MESSAGE_TYPE_IMAGE;
        break;
      case MediaType.video:
        message.messageType = MessageType.MESSAGE_TYPE_VIDEO;
        break;
    }
    message.content = jsonEncode(NetworkResource(
      url: upload,
      name: mediaInputContext.mediaFile.name,
    ));

    await chatController.sendMessage([message]);
  }

  handleInputFile(BuildContext context) async {
    handleCloseSheet(context);

    final filePath = await fileInputController.pickFile();
    if (filePath == null) return;

    final serviceUrl = await fileInputController.showPreviewDialog(filePath);
    if (serviceUrl == null) return;

    final upload = await scope.uploader.upload(serviceUrl, filePath);
    final message = await chatController.createMessage();
    message.content = jsonEncode(NetworkResource(
      url: upload,
      name: path.basename(filePath),
    ));
    message.messageType = MessageType.MESSAGE_TYPE_FILE;

    await chatController.sendMessage([message]);
  }

  handleCreateRTC(BuildContext context) {
    handleCloseSheet(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.extent(
        maxCrossAxisExtent: 75,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          if (!chatController.useTextInput)
            _InputMenuWrapper(
              onTap: () => handleToggleTextInput(context),
              icon: Icons.edit,
              label: '文本输入',
            )
          else
            _InputMenuWrapper(
              onTap: () => handleToogleVoiceInput(context),
              icon: Icons.mic,
              label: '语音输入',
            ),
          _InputMenuWrapper(
            onTap: () => handleInputMedia(context),
            icon: Icons.image,
            label: '图片/视频',
          ),
          _InputMenuWrapper(
            onTap: () => handleInputFile(context),
            icon: Icons.file_upload,
            label: '发送文件',
          ),
          _InputMenuWrapper(
            onTap: () => handleCreateRTC(context),
            icon: Icons.call,
            label: '音视频通话',
          ),
        ],
      ),
    );
  }
}

class _InputMenuWrapper extends StatelessWidget {
  final void Function() onTap;
  final String label;
  final IconData icon;
  const _InputMenuWrapper({
    required this.onTap,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          Icon(icon).padding(top: 4).expanded(),
          Text(
            label,
            style: const TextStyle(fontSize: 13),
            overflow: TextOverflow.ellipsis,
          ).padding(bottom: 8),
        ],
      ),
    );
  }
}
