import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';

class MessagesController extends ChangeNotifier {
  final BuildContext context;

  Scope get scope => context.read<Scope>();
  Conversation get conversation => context.read<Conversation>();

  final itemScrollController = ItemScrollController();
  final scrollOffsetController = ScrollOffsetController();
  final scrollOffsetListener = ScrollOffsetListener.create();
  final itemPositionListener = ItemPositionsListener.create();

  final lockBottomKey = UniqueKey();
  var lockBottom = false;

  MessagesController({
    required this.context,
  }) {
    _watchMessages();
  }

  final ids = <int>[];

  StreamSubscription? messagesSub;
  var inited = false;
  var uncheckIndex = 0;

  var _nextTickToBottom = false;

  handleNextTickToBottom() {
    _nextTickToBottom = true;
  }

  handleToBottom() {
    return itemScrollController.scrollTo(
      index: ids.length,
      duration: Durations.medium1,
      alignment: 1,
    );
  }

  handleToUncheck() {
    itemScrollController.scrollTo(
      index: uncheckIndex,
      duration: Durations.medium1,
      alignment: 1,
    );
  }

  void _watchMessages() async {
    final db = scope.db;
    final select = db.messages.selectOnly();
    select.addColumns([db.messages.id]);
    select.where(db.messages.conversationId.equals(conversation.id));
    select.orderBy([
      OrderingTerm.asc(db.messages.createdAt),
    ]);
    final stream = select
        .watch()
        .map((event) => event.map((e) => e.read(db.messages.id)!).toList());
    messagesSub = stream.listen((messages) async {
      int? uncheckId = await _findUncheckId();
      inited = true;
      uncheckIndex = messages.indexOf(uncheckId);
      if (uncheckIndex < 0) {
        uncheckId = messages.lastOrNull;
        uncheckIndex = messages.length;
      }

      ids.clear();
      ids.addAll(messages);
      ids.add(-1);
      notifyListeners();

      if (_nextTickToBottom || lockBottom) {
        _nextTickToBottom = false;
        Timer(Durations.short1, handleToBottom);
      }
    });
  }

  Future<int> _findUncheckId() async {
    final db = scope.db;

    final select = db.messageStates.selectOnly().join([
      innerJoin(
        db.messages,
        db.messages.id.equalsExp(db.messageStates.messageId),
      ),
      innerJoin(
        db.contacts,
        db.contacts.id.equalsExp(db.messageStates.contactId),
      ),
    ]);
    select.addColumns([db.messages.id]);
    select.where(Expression.and([
      db.messages.conversationId.equals(conversation.id),
      db.messageStates.checkedAt.isNull(),
      db.contacts.signPubkey.equals(scope.secret.signPubKey),
    ]));
    select.orderBy([
      OrderingTerm.asc(db.messages.createdAt),
    ]);
    select.limit(1);

    final record = await select.getSingleOrNull();
    return record?.read(db.messages.id) ?? -1;
  }

  @override
  void dispose() {
    messagesSub?.cancel();
    super.dispose();
  }
}
