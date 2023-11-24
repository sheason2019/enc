import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheason_chat/barcode/scanner/index.controller.dart';

class BarcodeScannerPage extends StatelessWidget {
  const BarcodeScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScannerController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('扫描二维码'),
      ),
      body: Container(),
    );
  }
}
