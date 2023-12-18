import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/accounts/account_avatar.view.dart';
import 'package:sheason_chat/chat/edit_member/edit_member.controller.dart';
import 'package:sheason_chat/chat/edit_member/edit_member.view.dart';
import 'package:sheason_chat/chat/room/room.view.dart';
import 'package:sheason_chat/dio.dart';
import 'package:sheason_chat/extensions/portable_conversation/portable_conversation.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:sheason_chat/utils/service_selector/service_selector.controller.dart';
import 'package:sheason_chat/utils/service_selector/service_selector.view.dart';
import 'package:sheason_chat/utils/sign_helper.dart';
import 'package:styled_widget/styled_widget.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  late EditMemberController controller;
  late ServiceSelectorController serviceController;

  Future<void> initDisableSet() async {
    final scope = context.read<Scope>();
    final select = scope.db.contacts.select();
    select.where((tbl) => tbl.signPubkey.equals(scope.secret.signPubKey));
    final contact = await select.getSingle();
    controller.disableSet.add(contact.id);
    controller.notify();
  }

  @override
  void initState() {
    final scope = context.read<Scope>();
    controller = EditMemberController(
      scope: scope,
      disableSet: {},
    );
    serviceController = ServiceSelectorController(scope);
    initDisableSet();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    serviceController.dispose();
    super.dispose();
  }

  handleEditMember() async {
    controller.selectSet.clear();
    controller.selectSet.addAll(controller.memberSet);

    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.add(EditMemberView(controller: controller));
    delegate.notify();
  }

  Future<Contact> findContact(int id) {
    final db = context.read<Scope>().db;
    final select = db.contacts.select();
    select.where((tbl) => tbl.id.equals(id));
    return select.getSingle();
  }

  void handleSubmit() async {
    final delegate = context.read<MainController>().rootDelegate;
    final url = serviceController.serviceUrl;
    if (url == null) {
      throw Exception('url cannot be null');
    }
    final scope = context.read<Scope>();

    final selectMembers = scope.db.contacts.select();
    selectMembers.where((tbl) => tbl.id.isIn(controller.memberSet));
    final members = await selectMembers.get();

    final portableConversation = PortableConversation()
      ..type = ConversationType.CONVERSATION_GROUP
      ..owner = scope.snapshot
      ..remoteUrl = url
      ..members.addAll(members.map((e) => e.snapshot));
    portableConversation.members.add(scope.snapshot);

    final postData = await SignHelper.wrap(
      scope,
      portableConversation.writeToBuffer(),
    );

    // 发送请求，请求内容为 SignWrapper<PortableConversation>
    final resp = await dio.post(
      '$url/group',
      data: FormData.fromMap({
        'data': base64Encode(postData.writeToBuffer()),
      }),
    );
    // 收到响应，响应内容为 SignWrapper<PortableConversation>
    final wrapper = SignWrapper.fromBuffer(base64Decode(resp.data));
    final conversation = PortableConversation.fromBuffer(
      await SignHelper.unwrap(scope, wrapper),
    );
    final operation = await scope.operator.factory.conversation(conversation);
    await scope.operator.apply([operation]);

    final agent = conversation.findAgent(scope);
    final selectConversation = scope.db.conversations.select();
    selectConversation.where((tbl) => tbl.signPubkey.equals(agent.signPubKey));
    final inserted = await selectConversation.getSingle();

    delegate.pages.removeLast();
    delegate.pages.add(ChatRoomPage(conversation: inserted));
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('创建群聊'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const Text(
            '群主',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          ListTile(
            leading: AccountAvatar(snapshot: scope.snapshot),
            title: Text(scope.snapshot.username),
            subtitle: Text(scope.secret.signPubKey),
          ),
          const Text(
            '成员',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ).padding(top: 16),
          ListenableBuilder(
            listenable: controller,
            builder: (context, _) => SingleChildScrollView(
              child: Wrap(
                spacing: 4,
                children: [
                  IconButton.outlined(
                    onPressed: handleEditMember,
                    icon: const Icon(Icons.edit),
                  ).width(40).height(40),
                  for (final id in controller.memberSet)
                    FutureBuilder(
                      future: findContact(id),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const SizedBox();
                        return AccountAvatar(
                          snapshot: snapshot.requireData.snapshot,
                        );
                      },
                    ),
                ],
              ),
            ),
          ).padding(top: 8, horizontal: 16).constrained(maxHeight: 360),
          const Text(
            '群聊信息',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ).padding(top: 16),
          ListTile(
            title: const Text('群聊服务器'),
            subtitle: ServiceSelector(controller: serviceController),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: handleSubmit,
        icon: const Icon(Icons.check),
        label: const Text('提交'),
      ),
    );
  }
}
