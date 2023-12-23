import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/contacts/detail/detail.view.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class NotifyMessageView extends StatelessWidget {
  const NotifyMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    final message = context.watch<Message>();

    final json = jsonDecode(message.content);
    final type = json['type'];

    return Builder(
      builder: (context) {
        switch (type) {
          case 'create':
            return _CreateConversation(
              signPubkey: json['payload'],
            );
          case 'invite':
            return _InviteMembers(
              operator: json['payload']['operator'],
              members: json['payload']['members'],
            );
          case 'remove':
            return _RemoveMembers(
              operator: json['payload']['operator'],
              members: json['payload']['members'],
            );
          default:
            return Text(message.content);
        }
      },
    ).center().padding(horizontal: 12, vertical: 8);
  }
}

class _CreateConversation extends StatelessWidget {
  final String signPubkey;
  const _CreateConversation({required this.signPubkey});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black),
        children: [
          WidgetSpan(
            child: _AccountText(
              signPubkey: signPubkey,
            ),
          ),
          const TextSpan(text: '创建了群聊'),
        ],
      ),
    );
  }
}

class _InviteMembers extends StatelessWidget {
  final String operator;
  final List members;

  const _InviteMembers({
    required this.operator,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black),
        children: [
          WidgetSpan(
            child: _AccountText(signPubkey: operator),
          ),
          const TextSpan(text: '邀请'),
          for (final member in members)
            WidgetSpan(
              child: _AccountText(
                signPubkey: member,
              ),
            ),
          const TextSpan(text: '加入群聊'),
        ],
      ),
    );
  }
}

class _RemoveMembers extends StatelessWidget {
  final String operator;
  final List members;

  const _RemoveMembers({
    required this.operator,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black),
        children: [
          WidgetSpan(
            child: _AccountText(signPubkey: operator),
          ),
          const TextSpan(text: '移除群聊成员'),
          for (final member in members)
            WidgetSpan(
              child: _AccountText(
                signPubkey: member,
              ),
            ),
        ],
      ),
    );
  }
}

class _AccountText extends StatelessWidget {
  final String signPubkey;
  const _AccountText({required this.signPubkey});

  Stream<Contact?> createStream(BuildContext context) {
    final scope = context.watch<Scope>();
    final select = scope.db.contacts.select()
      ..where((tbl) => tbl.signPubkey.equals(signPubkey));
    return select.watchSingleOrNull();
  }

  void handleTap(BuildContext context, Contact contact) {
    final delegate = context.read<Scope>().router.chatDelegate;
    delegate.pages.add(ContactDetailPage(snapshot: contact.snapshot));
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: createStream(context),
      builder: (context, snapshot) {
        void Function()? onTap;
        if (snapshot.data != null) {
          onTap = () => handleTap(context, snapshot.data!);
        }
        return GestureDetector(
          onTap: onTap,
          child: Text(
            snapshot.data?.snapshot.username ?? signPubkey,
            style: TextStyle(color: Colors.blue.shade300),
          ),
        );
      },
    ).padding(horizontal: 4);
  }
}
