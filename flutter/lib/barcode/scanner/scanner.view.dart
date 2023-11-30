import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/replica/proceed/proceed.view.dart';
import 'package:sheason_chat/replica/replica.view.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<StatefulWidget> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final controller = MobileScannerController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void proceedBarcode(String rawValue) {
    final json = jsonDecode(rawValue);
    switch (json['type']) {
      case 'replica':
        return handleReplica(json);
      default:
        return;
    }
  }

  void handleReplica(Map json) {
    debugPrint('Scanned replica $json');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('扫描二维码'),
      ),
      body: MobileScanner(
        onDetect: (capture) {
          final barcodes = capture.barcodes;
          final value = barcodes.first.rawValue;
          if (value != null) {
            controller.stop();
            proceedBarcode(value);
          }
        },
      ),
    );
  }
}
