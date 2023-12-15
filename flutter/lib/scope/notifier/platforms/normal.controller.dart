import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as ln;
import 'package:sheason_chat/chat/anchors/anchor/anchor_message_preview/message_preview_helper.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/notifier/notifier.controller.dart';
import 'package:sheason_chat/scope/notifier/notifier_helper.dart';
import 'package:sheason_chat/scope/scope.collection.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class NormalNotifier implements Notifier {
  final plugin = ln.FlutterLocalNotificationsPlugin();

  @override
  Future<void> message(Scope scope, Message message) async {
    final select = scope.db.contacts.select();
    select.where((tbl) => tbl.id.equals(message.contactId));
    final contact = await select.getSingle();

    final avatarPath = await NotifierHelper.avatarPath(scope, contact);

    final channelId = message.conversationId.toString();
    final displayMessage = <String>[];
    final notifications = await plugin.getActiveNotifications();
    for (final noti in notifications) {
      if (noti.channelId != channelId) continue;

      final tag = noti.tag;
      if (tag != null) {
        final List messages = jsonDecode(tag);
        displayMessage.addAll(messages.map((e) => e.toString()));
      }
      await plugin.cancel(noti.id!, tag: noti.tag);
    }

    displayMessage.insert(0, MessagePreviewHelper.previewStr(message));

    final notificationDetails = ln.NotificationDetails(
      android: ln.AndroidNotificationDetails(
        channelId,
        'conversation/${message.conversationId}',
        styleInformation: ln.InboxStyleInformation(
          displayMessage,
          contentTitle: contact.snapshot.username,
          summaryText: scope.snapshot.username,
        ),
        tag: jsonEncode(displayMessage),
        largeIcon: ln.FilePathAndroidBitmap(avatarPath),
        groupKey: 'conversation/${message.conversationId}',
      ),
    );

    final payload = 'conversation/${scope.secret.signPubKey}/'
        '${message.conversationId}';

    await plugin.show(
      message.id,
      contact.snapshot.username,
      '${displayMessage.length}条新消息',
      notificationDetails,
      payload: payload,
    );
  }

  @override
  Future<void> initial(
    MainController controller,
    ScopeCollection collection,
  ) async {
    const ln.AndroidInitializationSettings initializationSettingsAndroid =
        ln.AndroidInitializationSettings('@mipmap/ic_launcher');
    const ln.DarwinInitializationSettings initializationSettingsDarwin =
        ln.DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    const ln.InitializationSettings initializationSettings =
        ln.InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await plugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        NotifierHelper.handleActivateMessage(
          controller,
          collection,
          details.payload ?? '',
        );
      },
    );
  }
}
