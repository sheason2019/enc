import 'dart:convert';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheason_chat/scope/scope.model.dart';

import 'export.controller.dart';

class ExportReplicaPage extends StatelessWidget {
  const ExportReplicaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = Get.find<Scope>();
    final controller = Get.put(ExportReplicaController(scope: scope));

    return Scaffold(
      appBar: AppBar(
        title: const Text('复制账号'),
      ),
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Center(
            child: SizedBox(
              width: 256,
              height: 256,
              child: Obx(
                () => Stack(
                  children: [
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: BarcodeWidget(
                          barcode: Barcode.qrCode(
                            errorCorrectLevel: BarcodeQRCorrectionLevel.medium,
                          ),
                          data: jsonEncode({
                            'type': 'replica',
                            'url': 'http://192.168.31.174',
                            'socketId': controller.socketId.value,
                          }),
                        ),
                      ),
                    ),
                    if (controller.scanned.value)
                      Positioned.fill(
                        child: ColoredBox(
                          color: Colors.black.withOpacity(0.75),
                          child: const Center(
                            child: Text(
                              '已扫描二维码',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('验证码 ${controller.verifyCode}'),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: FilledButton(
                    onPressed: controller.handleTransport,
                    child: const Text('传输账号副本'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
