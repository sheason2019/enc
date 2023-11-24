import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheason_chat/chat/chat.view.dart';
import 'package:sheason_chat/profile/profile.view.dart';
import 'package:sheason_chat/scope/scope.controller.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class ScopePage extends StatelessWidget {
  final Scope scope;
  const ScopePage({super.key, required this.scope});

  @override
  Widget build(BuildContext context) {
    Get.put(scope);
    final controller = Get.put(ScopeController(scope: scope));

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
  }
}
