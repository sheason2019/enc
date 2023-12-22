import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class MessageStateProgressView extends StatelessWidget {
  const MessageStateProgressView({super.key});

  Stream<double?> progress(BuildContext context) {
    final scope = context.watch<Scope>();
    final message = context.watch<Message>();

    final checked = scope.db.messageStates.id.count(
      filter: scope.db.messageStates.checkedAt.isNotNull(),
    );
    final count = scope.db.messageStates.id.count();
    final select = scope.db.messageStates.selectOnly();
    select.addColumns([checked, count]);
    select.where(scope.db.messageStates.messageId.equals(message.id));
    return select.watchSingle().map((event) {
      final c = event.read(count);
      if (c == 0) return null;

      return event.read(checked)! / event.read(count)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double?>(
      initialData: 0,
      stream: progress(context),
      builder: (context, snapshot) {
        final value = snapshot.data;

        if (value == null) {
          return const SizedBox.shrink();
        }

        return CircularProgressIndicator(
          value: value,
          backgroundColor: Colors.black12,
          strokeWidth: 2.5,
        );
      },
    ).width(16).height(16).padding(vertical: 6, horizontal: 4);
  }
}
