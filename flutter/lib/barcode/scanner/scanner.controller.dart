import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/contacts/search/search.controller.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/replica/proceed/proceed.view.dart';
import 'package:sheason_chat/replica/replica.view.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class ScanResultController {
  void handleReplica(BuildContext context, Map json) {
    late ReplicaDataDirection direction;
    switch (json['dataDirection']) {
      case 'push':
        direction = ReplicaDataDirection.pull;
        break;
      case 'pull':
        direction = ReplicaDataDirection.push;
        break;
      default:
        throw Exception(
          'Unknown replica data direction: ${json['dataDirection']}',
        );
    }

    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.removeLast();
    delegate.pages.add(
      ReplicaProceedPage(
        url: json['url'],
        scope: context.read<Scope?>(),
        dataDirection: direction,
        connDirection: ReplicaConnDirection.connect,
        namespace: json['namespace'],
      ),
    );
    delegate.notify();
  }

  void handlePlain(BuildContext context, String rawValue) {
    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.removeLast();
    delegate.pages.add(
      Scaffold(
        appBar: AppBar(
          title: const Text('扫描结果'),
        ),
        body: Text(rawValue),
      ),
    );
    delegate.notify();
  }

  void handleAccount(BuildContext context, Map json) async {
    final url = json['url'];
    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.removeLast();
    await SearchContactController.handleSearch(context, url);
    delegate.notify();
  }
}
