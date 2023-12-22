import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/chat/message_debug/body.view.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';

class MessageDebugPage extends StatelessWidget {
  final Message message;
  const MessageDebugPage({super.key, required this.message});

  Stream<Message> fetchStream(BuildContext context) {
    final scope = context.watch<Scope>();
    final select = scope.db.messages.select();
    select.where((tbl) => tbl.id.equals(message.id));
    return select.watchSingle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message ${message.id}'),
      ),
      body: StreamBuilder<Message>(
        initialData: message,
        stream: fetchStream(context),
        builder: (context, snapshot) => Provider.value(
          value: snapshot.requireData,
          builder: (context, child) => const MessageDebugPageBody(),
        ),
      ),
    );
  }
}
