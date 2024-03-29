import 'dart:io';

import 'package:ENC/scope/persist_adapter/persist_adapter.dart';
import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as path;
import 'package:ENC/chat/room/room.view.dart';
import 'package:ENC/dio.dart';
import 'package:ENC/main.controller.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';

class NotifierHelper {
  NotifierHelper._();

  static Future<String> avatarPath(Scope scope, Contact contact) async {
    var avatarUrl = contact.snapshot.avatarUrl;
    if (avatarUrl.isEmpty) {
      avatarUrl =
          'https://api.multiavatar.com/${contact.snapshot.index.signPubKey}.png';
    }

    final avatarFile = File(path.join(
      scope.paths.cache,
      'avatars',
      Uri.encodeComponent(avatarUrl),
    ));
    final dir = Directory(path.dirname(avatarFile.path));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    if (!await avatarFile.exists()) {
      try {
        await dio.download(avatarUrl, avatarFile.path);
      } catch (e) {
        debugPrint('download random avatar failed');
      }
    }

    return avatarFile.path;
  }

  static Future<void> handleActivateMessage(
    MainController controller,
    PersistAdapter adapter,
    String payload,
  ) async {
    final argument = payload.split('/');
    if (argument[0] != 'conversation') {
      throw UnimplementedError();
    }

    final signPubkey = argument[1];
    final scope = adapter.scopeMap[signPubkey];
    if (scope == null) return;
    final conversationId = int.parse(argument[2]);

    await controller.handleEnterScope(adapter, scope);
    final delegate = scope.router.chatDelegate;
    final select = scope.db.conversations.select();
    select.where((tbl) => tbl.id.equals(conversationId));
    final conversation = await select.getSingle();

    delegate.pages.add(ChatRoomPage(conversation: conversation));
    delegate.notify();
  }
}
