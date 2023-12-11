import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/contacts/detail/detail.view.dart';
import 'package:sheason_chat/cyprto/crypto_keypair.dart';
import 'package:sheason_chat/cyprto/crypto_utils.dart';
import 'package:sheason_chat/dio.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class SearchContactPage extends StatefulWidget {
  const SearchContactPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchContactPageState();
}

class _SearchContactPageState extends State<SearchContactPage> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  handleSubmit() async {
    final scope = context.read<Scope>();
    final delegate = context.read<MainController>().rootDelegate;
    final url = textController.text;
    final resp = await dio.get(url);
    final snapshotBuffer = base64Decode(resp.data['snapshot']);
    final snapshot = AccountSnapshot.fromBuffer(snapshotBuffer);
    final signature = base64Decode(resp.data['signature']);

    final verify = await CryptoUtils.verifySignature(
      snapshotBuffer,
      Signature(
        signature,
        publicKey: CryptoKeyPair.createSignPubKey(snapshot.index.signPubKey)!,
      ),
    );
    if (!verify) {
      throw Exception('Verify signature failed');
    }

    // 更新联系人信息
    final operation = await scope.operator.factory.contact(snapshot);
    await scope.operator.apply([operation]);

    delegate.pages.add(ContactDetailPage(snapshot: snapshot));
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('搜索网络联系人'),
      ),
      body: TextField(
        controller: textController,
        decoration: const InputDecoration(
          label: Text('输入用户 URL'),
        ),
        onSubmitted: (_) => handleSubmit(),
      ).padding(vertical: 12).width(380).center(),
      floatingActionButton: FloatingActionButton(
        onPressed: handleSubmit,
        child: const Icon(Icons.check),
      ),
    );
  }
}
