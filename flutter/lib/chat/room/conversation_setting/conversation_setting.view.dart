import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/chat/room/conversation_setting/group/group.view.dart';
import 'package:ENC/chat/room/conversation_setting/member/member.view.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';

class ConversationSettingPage extends StatelessWidget {
  final Conversation conversation;
  const ConversationSettingPage({
    super.key,
    required this.conversation,
  });

  Widget titleBuilder(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Stream<Conversation> createStream(BuildContext context) {
    final scope = context.read<Scope>();
    final select = scope.db.conversations.select();
    select.where((tbl) => tbl.id.equals(conversation.id));
    return select.watchSingle();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: conversation,
      stream: createStream(context),
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(
          title: const Text('会话设置'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            GroupMembers(conversation: snapshot.requireData),
            if (snapshot.requireData.type ==
                ConversationType.CONVERSATION_GROUP)
              GroupSettings(conversation: snapshot.requireData),
          ],
        ),
      ),
    );
  }
}
