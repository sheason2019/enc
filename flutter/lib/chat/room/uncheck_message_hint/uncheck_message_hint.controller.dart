import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';

class UncheckMessageHintController extends ValueNotifier<int> {
  final BuildContext context;

  Scope get scope => context.read<Scope>();
  Conversation get conversation => context.read<Conversation>();

  UncheckMessageHintController({
    required this.context,
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
