import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/main.controller.dart';
import 'package:ENC/rtc/member_list/member_list.view.dart';
import 'package:ENC/rtc/rtc.controller.dart';
import 'package:styled_widget/styled_widget.dart';

class RtcPageControl extends StatelessWidget {
  const RtcPageControl({super.key});

  toMemberList(BuildContext context) {
    final controller = context.read<RtcController>();
    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.add(RtcMemberListPage(controller: controller));
    delegate.notify();
  }

  toggleVideo(BuildContext context) {
    final controller = context.read<RtcController>();
    controller.videoOpen = !controller.videoOpen;
  }

  toggleAudio(BuildContext context) {
    final controller = context.read<RtcController>();
    controller.audioOpen = !controller.audioOpen;
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RtcController>();

    return Row(
      children: [
        _Button(
          onTap: () => toggleAudio(context),
          label: controller.audioOpen ? '音频:开启' : '音频:关闭',
          iconData: controller.audioOpen ? Icons.mic : Icons.mic_off,
        ),
        _Button(
          onTap: () => toggleVideo(context),
          label: controller.videoOpen ? '视频:开启' : '视频:关闭',
          iconData: controller.videoOpen ? Icons.videocam : Icons.videocam_off,
        ),
        _Button(
          onTap: () => toMemberList(context),
          label: '用户列表',
          iconData: Icons.people,
        ),
        _Button(
          onTap: () {},
          label: '设置',
          iconData: Icons.settings,
        ),
      ],
    ).height(72).border(top: 1, color: Colors.black26);
  }
}

class _Button extends StatelessWidget {
  final void Function() onTap;
  final IconData iconData;
  final String label;

  const _Button({
    required this.onTap,
    required this.label,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData),
          Text(label),
        ],
      ),
    ).expanded();
  }
}
