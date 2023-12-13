import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class RtcPageControl extends StatelessWidget {
  const RtcPageControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Button(
          onTap: () {},
          label: '音频',
          iconData: Icons.mic,
        ),
        _Button(
          onTap: () {},
          label: '视频',
          iconData: Icons.videocam,
        ),
        _Button(
          onTap: () {},
          label: '用户列表',
          iconData: Icons.people,
        ),
        _Button(
          onTap: () {},
          label: '设置',
          iconData: Icons.settings,
        ),
        _Button(
          onTap: () {},
          label: '隐藏菜单',
          iconData: Icons.arrow_drop_down,
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
