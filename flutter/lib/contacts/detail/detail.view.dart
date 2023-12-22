import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ENC/accounts/account_avatar.view.dart';
import 'package:ENC/chat/room/room.view.dart';
import 'package:ENC/extensions/portable_conversation/portable_conversation.dart';
import 'package:ENC/main.controller.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';

class ContactDetailPage extends StatelessWidget {
  final AccountSnapshot snapshot;
  const ContactDetailPage({super.key, required this.snapshot});

  Future<Conversation> putConversation(BuildContext context) async {
    final scope = context.read<Scope>();

    final portable = PortableConversation()
      ..type = ConversationType.CONVERSATION_PRIVATE
      ..members.addAll({
        scope.snapshot.index.signPubKey: scope.snapshot,
        snapshot.index.signPubKey: snapshot,
      }.values);
    final agent = portable.findAgent(scope);
    final select = scope.db.conversations.select();
    select.where(
      (tbl) => tbl.type.equalsValue(ConversationType.CONVERSATION_PRIVATE),
    );
    select.where((tbl) => tbl.signPubkey.equals(agent.signPubKey));
    var conversation = await select.getSingleOrNull();
    if (conversation != null) {
      return conversation;
    }

    final operation = await scope.operator.factory.conversation(portable);
    await scope.operator.apply([operation], isReplay: false);
    return select.getSingle();
  }

  toPrivateConversation(BuildContext context) async {
    final delegate = context.read<MainController>().rootDelegate;
    final conversation = await putConversation(context);
    delegate.pages.removeRange(1, delegate.pages.length);
    delegate.pages.add(ChatRoomPage(conversation: conversation));
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('用户详情'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: AccountAvatar(snapshot: snapshot),
            title: Text(
              snapshot.username,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            onLongPress: () {
              Clipboard.setData(
                ClipboardData(text: snapshot.index.ecdhPubKey),
              );
            },
            title: const Text('ECDH Public Key'),
            subtitle: Text(snapshot.index.ecdhPubKey),
          ),
          ListTile(
            onLongPress: () {
              Clipboard.setData(
                ClipboardData(text: snapshot.index.signPubKey),
              );
            },
            title: const Text('SIGN Public Key'),
            subtitle: Text(snapshot.index.signPubKey),
          ),
          ListTile(
            title: const Text('Service URL'),
            subtitle: Text(snapshot.serviceMap.keys.join('\n')),
          ),
          ListTile(
            onTap: () => toPrivateConversation(context),
            title: const Text('发起会话'),
          ),
        ],
      ),
    );
  }
}
