import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/accounts/account_avatar.view.dart';
import 'package:sheason_chat/rtc/rtc.controller.dart';
import 'package:sheason_chat/rtc/rtc.model/member.dart';
import 'package:styled_widget/styled_widget.dart';

class MemberMediaCard extends StatelessWidget {
  final RtcMember member;
  const MemberMediaCard({
    super.key,
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RtcController>();
    final isCurrent = member.clientId == controller.socket?.id;

    final renderer = member.session?.renderer ?? controller.renderer;

    return ListenableBuilder(
        listenable: Listenable.merge([
          controller,
          member.session,
        ]),
        builder: (context, _) {
          final audioOpen =
              isCurrent ? controller.audioOpen : member.session!.audioOpen;
          final videoOpen =
              isCurrent ? controller.videoOpen : member.session!.videoOpen;
          return Card(
            clipBehavior: Clip.hardEdge,
            color: Colors.grey,
            child: Stack(
              children: [
                AccountAvatar(snapshot: member.snapshot).positioned(
                  left: 8,
                  top: 8,
                ),
                Icon(
                  audioOpen ? Icons.mic : Icons.mic_off,
                ).center(),
                if (videoOpen)
                  Positioned.fill(
                    child: RTCVideoView(
                      renderer,
                      objectFit:
                          RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    ),
                  ),
              ],
            ),
          );
        });
  }
}
