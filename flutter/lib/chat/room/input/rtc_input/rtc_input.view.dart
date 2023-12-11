import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/input/rtc_input/rtc_input.controller.dart';
import 'package:sheason_chat/chat/room/room.controller.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/utils/service_selector/service_selector.view.dart';

class CreateRTCInvitePage extends StatelessWidget {
  final ChatController controller;

  const CreateRTCInvitePage({
    super.key,
    required this.controller,
  });

  Future<void> handleSubmit(BuildContext context) async {
    final controller = context.read<CreateRTCInviteController>();
    final delegate = context.read<MainController>().rootDelegate;
    await controller.handleSubmit();

    delegate.pages.removeLast();
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (context) => CreateRTCInviteController(
        chatController: controller,
      ),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: const Text('创建音视频通信邀请'),
        ),
        body: _FormBody(controller: controller),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => handleSubmit(context),
          icon: const Icon(Icons.check),
          label: const Text('提交'),
        ),
      ),
    );
  }
}

class _FormBody extends StatelessWidget {
  final ChatController controller;
  const _FormBody({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CreateRTCInviteController>();

    return ListView(
      children: [
        const ListTile(
          title: Text('组网方式'),
          subtitle: Text('Mesh'),
        ),
        ListTile(
          title: const Text('信令服务器'),
          subtitle: ServiceSelector(controller: controller.serviceController),
        ),
        ListTile(
          title: const Text('加入会议权限'),
          subtitle: DropdownButton<int>(
            isExpanded: true,
            value: controller.joinLimit,
            onChanged: (v) => controller.joinLimit = v ?? 0,
            items: const [
              DropdownMenuItem(
                value: 0,
                child: Text('任意用户可加入'),
              ),
              DropdownMenuItem(
                value: 1,
                child: Text('指定用户可加入'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
