import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheason_chat/replica/import/import.controller.dart';

class ImportReplicaPage extends StatelessWidget {
  final String url;
  final String socketId;

  const ImportReplicaPage({
    super.key,
    required this.url,
    required this.socketId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImportReplicaController(
      url: url,
      socketId: socketId,
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('生成账号副本'),
      ),
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Center(
            child: CircularProgressIndicator(),
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    leading: const CircleAvatar(),
                    title: Text(
                      controller.snapshot.value.username,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      controller.snapshot.value.index.signPubKey,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Center(
                      child: controller.verifyCode.value.isNotEmpty
                          ? Text('验证码 ${controller.verifyCode.value}')
                          : FilledButton(
                              onPressed: controller.handleRequest,
                              child: const Text('请求传输账号副本'),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
