import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheason_chat/chat/chat.view.dart';
import 'package:sheason_chat/profile/profile.view.dart';
import 'package:sheason_chat/scope/scope.controller.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class ScopePage extends StatelessWidget {
  const ScopePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = Get.find<Scope>();
    final controller = Get.find<ScopeController>();
    Get.log('put scope');

    return Obx(() {
      if (!scope.inited.value) {
        return const Scaffold();
      }

      return Scaffold(
        body: Obx(
          () => IndexedStack(
            index: controller.tabIndex.value,
            children: [
              const ChatView(),
              Container(),
              const ProfileView(),
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => NavigationBar(
            selectedIndex: controller.tabIndex.value,
            onDestinationSelected: (v) => controller.tabIndex.value = v,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.chat),
                label: '消息',
              ),
              NavigationDestination(
                icon: Icon(Icons.people),
                label: '联系人',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_circle),
                label: '档案',
              ),
            ],
          ),
        ),
      );
    });
  }
}
