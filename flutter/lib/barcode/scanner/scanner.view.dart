import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sheason_chat/barcode/scanner/scanner.controller.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<StatefulWidget> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final controller = MobileScannerController();
  final resultController = ScanResultController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void proceedBarcode(String rawValue) {
    final json = jsonDecode(rawValue);
    switch (json['type']) {
      case 'replica':
        return resultController.handleReplica(context, json);
      case 'account':
        return resultController.handleAccount(context, json);
      default:
        return resultController.handlePlain(context, rawValue);
    }
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
