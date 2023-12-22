import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/accounts/account_avatar.view.dart';
import 'package:ENC/chat/edit_member/edit_member.controller.dart';
import 'package:ENC/chat/edit_member/edit_member.view.dart';
import 'package:ENC/dio.dart';
import 'package:ENC/main.controller.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:ENC/utils/sign_helper.dart';
import 'package:styled_widget/styled_widget.dart';

class GroupMembers extends StatefulWidget {
  final Conversation conversation;
  const GroupMembers({super.key, required this.conversation});

  @override
  State<StatefulWidget> createState() => _GroupMembersState();
}

class _GroupMembersState extends State<GroupMembers> {
  late final EditMemberController controller;

  initController() async {
    controller = EditMemberController(
      scope: context.read<Scope>(),
      disableSet: {},
    );
    final scope = context.read<Scope>();
    final select = scope.db.contacts.select();
    select.where((tbl) => tbl.signPubkey.equals(scope.secret.signPubKey));
    final contact = await select.getSingleOrNull();
    if (contact != null) {
      controller.disableSet.add(contact.id);
      controller.notify();
    }

    final selectMembers = scope.db.contacts.select();
    selectMembers.where(
      (tbl) => tbl.signPubkey.isIn(
        widget.conversation.info.members.map((e) => e.index.signPubKey),
      ),
    );
    final members = await selectMembers.get();
    controller.memberSet.addAll(members.map((e) => e.id));
  }

  handleEditMember() async {
    final scope = context.read<Scope>();
    final delegate = context.read<MainController>().rootDelegate;

    final selectMembers = scope.db.contacts.select();
    selectMembers.where(
      (tbl) => tbl.signPubkey.isIn(
        widget.conversation.info.members.map((e) => e.index.signPubKey),
      ),
    );
    final members = await selectMembers.get();
    controller.selectSet.clear();
    controller.selectSet.addAll(members.map((e) => e.id));

    delegate.pages.add(EditMemberView(
      controller: controller,
      onSubmited: handleSubmit,
    ));
    delegate.notify();
  }

  handleSubmit() async {
    final scope = context.read<Scope>();
    final select = scope.db.contacts.select();
    select.where((tbl) => tbl.id.isIn(controller.selectSet));
    final contacts = await select.get();
    final members = contacts
        .map((e) => e.snapshot)
        .map((e) => e.writeToBuffer())
        .map((e) => base64Encode(e))
        .toList();
    final buffer = utf8.encode(jsonEncode({
      'members': members,
      'groupId': widget.conversation.info.agent.signPubKey,
    }));
    final wrapper = await SignHelper.wrap(
      scope,
      buffer,
      contentType: ContentType.CONTENT_BUFFER,
    );
    final url = widget.conversation.info.remoteUrl;
    final id = widget.conversation.info.agent.signPubKey;
    await dio.put(
      '$url/group/$id/members',
      data: FormData.fromMap(
        {'data': base64Encode(wrapper.writeToBuffer())},
      ),
    );
  }

  @override
  void initState() {
    initController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          '成员信息',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Wrap(
          spacing: 4,
          children: [
            if (widget.conversation.type !=
                ConversationType.CONVERSATION_PRIVATE)
              IconButton.outlined(
                onPressed: handleEditMember,
                icon: const Icon(Icons.edit),
              ),
            for (final member in widget.conversation.info.members)
              AccountAvatar(snapshot: member),
          ],
        ).constrained(maxHeight: 360),
      ],
    ).padding(bottom: 8);
  }
}
