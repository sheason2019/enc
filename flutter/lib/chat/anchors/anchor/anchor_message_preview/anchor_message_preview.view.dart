import 'package:flutter/material.dart';
import 'package:ENC/chat/anchors/anchor/anchor_message_preview/message_preview_helper.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/schema/database.dart';

class ConversationAnchorMessagePreview extends StatelessWidget {
  final Message? message;
  const ConversationAnchorMessagePreview({
    super.key,
    required this.message,
  });

  String get previewStr {
    final message = this.message;
    if (message == null) return '';

    return MessagePreviewHelper.previewStr(message);
  }

  Color get previewColor {
    final message = this.message;
    if (message == null) return Colors.black;
    // 未知消息 使用 orange
    // network resource 使用 blue
    switch (message.messageType) {
      case MessageType.MESSAGE_TYPE_TEXT:
        return Colors.black;
      case MessageType.MESSAGE_TYPE_AUDIO:
      case MessageType.MESSAGE_TYPE_IMAGE:
      case MessageType.MESSAGE_TYPE_VIDEO:
      case MessageType.MESSAGE_TYPE_RTC:
      case MessageType.MESSAGE_TYPE_FILE:
        return Colors.blue;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      previewStr,
      style: TextStyle(color: previewColor),
    );
  }
}
