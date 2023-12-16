import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class UncheckMessageHintController extends ValueNotifier<int> {
  final Scope scope;
  final Conversation conversation;

  UncheckMessageHintController({
    required this.scope,
    required this.conversation,
  }) : super(0) {
    _watchUncheck();
  }

  StreamSubscription? uncheckSub;
  void _watchUncheck() {
    final count = scope.db.messageStates.id.count();
    final select = scope.db.messageStates.selectOnly().join([
      innerJoin(
        scope.db.contacts,
        scope.db.contacts.id.equalsExp(scope.db.messageStates.contactId),
      ),
      innerJoin(
        scope.db.messages,
        scope.db.messages.id.equalsExp(scope.db.messageStates.messageId),
      ),
    ]);
    select.addColumns([count]);
    select.where(scope.db.contacts.signPubkey.equals(scope.secret.signPubKey));
    select.where(scope.db.messageStates.checkedAt.isNull());
    select.where(scope.db.messages.conversationId.equals(conversation.id));
    final stream = select.watchSingle().map((event) => event.read(count)!);
    uncheckSub = stream.listen((event) {
      value = event;
    });
  }

  @override
  void dispose() {
    uncheckSub?.cancel();
    super.dispose();
  }
}
