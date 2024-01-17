// 消息推送
// 在 Subscribe 获取消息并在本地生成新消息后
// 调用 Notifier 通知用户收到新消息
import 'dart:io';

import 'package:ENC/main.controller.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/notifier/platforms/normal.controller.dart';
import 'package:ENC/scope/notifier/platforms/win.controller.dart';
import 'package:ENC/scope/persist_adapter/persist_adapter.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:flutter/foundation.dart';

abstract class Notifier {
  Scope? blockScope;
  Conversation? blockConversation;

  Future<void> message(Scope scope, Message message);

  Future<void> initial(
    MainController controller,
    PersistAdapter adapter,
  );

  Future<void> clean(
    Scope scope,
    Conversation conversation,
  );

  factory Notifier.create() {
    if (kIsWeb) {
      return NormalNotifier();
    }
    if (Platform.isWindows) {
      return WinNotifier();
    } else {
      return NormalNotifier();
    }
  }
}
