import 'package:ENC/prototypes/core.pbenum.dart';
import 'package:ENC/schema/database.dart';

class MessagePreviewHelper {
  MessagePreviewHelper._();
  static previewStr(Message message) {
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
}
