// 消息推送
// 在 Subscribe 获取消息并在本地生成新消息后
// 调用 Notifier 通知用户收到新消息
import 'dart:io';

import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/notifier/platforms/normal.controller.dart';
import 'package:sheason_chat/scope/notifier/platforms/win.controller.dart';
import 'package:sheason_chat/scope/scope.collection.dart';
import 'package:sheason_chat/scope/scope.model.dart';

abstract class Notifier {
  Scope? blockScope;
  Conversation? blockConversation;

  Future<void> message(Scope scope, Message message);

  Future<void> initial(
    MainController controller,
    ScopeCollection collection,
  );

  factory Notifier.create() {
    if (Platform.isWindows) {
      return WinNotifier();
    } else {
      return NormalNotifier();
    }
  }
}
