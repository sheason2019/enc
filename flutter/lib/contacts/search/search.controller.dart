import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/contacts/detail/detail.view.dart';
import 'package:ENC/cyprto/crypto_keypair.dart';
import 'package:ENC/cyprto/crypto_utils.dart';
import 'package:ENC/dio.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/scope/scope.model.dart';

class SearchContactController {
  SearchContactController._();

  static Future<void> handleSearchAndEnterContactPage(
    BuildContext context,
    String url,
  ) async {
    final scope = context.read<Scope>();
    final delegate = scope.router.contactDelegate;
    final snapshot = await handleSearch(url);
    // 更新联系人信息
    final operation = await scope.operator.factory.contact(snapshot);
    await scope.operator.apply([operation], isReplay: false);

    delegate.pages.add(ContactDetailPage(snapshot: snapshot));
    delegate.notify();
  }

  static Future<AccountSnapshot> handleSearch(
    String url,
  ) async {
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

    return snapshot;
  }
}
