import 'package:flutter/material.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';

class ConversationAnchorMessagePreview extends StatelessWidget {
  final Message? message;
  const ConversationAnchorMessagePreview({
    super.key,
    required this.message,
  });

  String get previewStr {
    final message = this.message;
    if (message == null) return '';

    switch (message.messageType) {
      case MessageType.MESSAGE_TYPE_TEXT:
        return message.content;
      case MessageType.MESSAGE_TYPE_AUDIO:
        return '[语音消息]';
      case MessageType.MESSAGE_TYPE_VIDEO:
        return '[视频]';
      case MessageType.MESSAGE_TYPE_IMAGE:
        return '[图片]';
      case MessageType.MESSAGE_TYPE_FILE:
        return '[文件]';
      case MessageType.MESSAGE_TYPE_RTC:
        return '[通话邀请]';
      default:
        return '收到一条新消息';
    }
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
