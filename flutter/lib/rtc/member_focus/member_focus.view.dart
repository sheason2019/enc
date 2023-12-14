import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sheason_chat/accounts/account_avatar.view.dart';
import 'package:sheason_chat/rtc/member_media_card/member_media_card.view.dart';
import 'package:sheason_chat/rtc/rtc.controller.dart';
import 'package:sheason_chat/rtc/rtc.model/member.dart';
import 'package:styled_widget/styled_widget.dart';

class MemberFocusPage extends StatelessWidget {
  final RtcMember member;
  final RtcController controller;
  const MemberFocusPage({
    super.key,
    required this.member,
    required this.controller,
  });

  RTCVideoRenderer get renderer {
    return member.session?.renderer ?? controller.renderer;
  }

  @override
  Widget build(BuildContext context) {
    final session = member.session;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            AccountAvatar(snapshot: member.snapshot).padding(right: 12),
            Text(member.snapshot.username),
          ],
        ),
      ),
      body: Column(
        children: [
          MemberMediaCardCore(
            member: member,
            audioOpen: session?.audioOpen ?? controller.audioOpen,
            videoOpen: session?.videoOpen ?? controller.videoOpen,
            muted: session?.muted ?? false,
            renderer: renderer,
          ).expanded(),
        ],
      ),
    );
  }
}
