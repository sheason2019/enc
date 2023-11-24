import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheason_chat/chat/chat.controller.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('消息列表'),
        centerTitle: true,
        leading: Center(
          child: GestureDetector(
            onTap: controller.handleEnterAccounts,
            child: const MouseRegion(
              cursor: SystemMouseCursors.click,
              child: CircleAvatar(),
            ),
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            onSelected: (v) {
              switch (v) {
                case 0:
                  controller.handleEnterBarcode();
                  return;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: Text('扫一扫'),
              ),
            ],
            icon: const Icon(Icons.add),
          ).paddingOnly(right: 8),
        ],
      ),
    );
  }
}
