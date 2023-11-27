import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/replica/import/import.view.dart';

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
        return handleImportReplica(json);
      default:
        return;
    }
  }

  void handleImportReplica(Map json) {
    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.removeLast();
    delegate.pages.add(
      ImportReplicaPage(url: json['url'], socketId: json['socketId']),
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
            proceedBarcode(value);
          }
        },
      ),
    );
  }
}
