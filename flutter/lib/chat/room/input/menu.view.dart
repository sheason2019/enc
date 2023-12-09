import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/room.controller.dart';
import 'package:styled_widget/styled_widget.dart';

class InputMenuIconButton extends StatelessWidget {
  const InputMenuIconButton({super.key});

  void handleClick(BuildContext context) {
    final controller = context.read<ChatRoomController>();
    showModalBottomSheet(
      context: context,
      builder: (context) => InputMenuBottomSheet(
        controller: controller,
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
  final ChatRoomController controller;
  const InputMenuBottomSheet({
    super.key,
    required this.controller,
  });

  handleCloseSheet(BuildContext context) {
    Navigator.of(context).pop();
  }

  handleToogleVoiceInput(BuildContext context) {
    controller.useTextInput = false;
    handleCloseSheet(context);
  }

  handleToggleTextInput(BuildContext context) {
    controller.useTextInput = true;
    handleCloseSheet(context);
  }

  handleInputMedia(BuildContext context) {
    handleCloseSheet(context);
  }

  handleInputFile(BuildContext context) {
    handleCloseSheet(context);
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
          if (!controller.useTextInput)
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
