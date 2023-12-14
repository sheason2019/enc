import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/accounts/account_avatar.view.dart';
import 'package:sheason_chat/rtc/rtc.controller.dart';
import 'package:sheason_chat/rtc/rtc.model/member.dart';
import 'package:styled_widget/styled_widget.dart';

class MemberMediaCard extends StatefulWidget {
  final RtcMember member;
  const MemberMediaCard({
    super.key,
    required this.member,
  });

  @override
  State<StatefulWidget> createState() => _MemberMediaCardState();
}

class _MemberMediaCardState extends State<MemberMediaCard> {
  var menuOpen = false;

  Timer? _timer;

  bool get muted => widget.member.session?.muted ?? false;
  bool get audioOpen =>
      (widget.member.session?.audioOpen ??
          context.read<RtcController>().audioOpen) &&
      !muted;
  bool get videoOpen =>
      (widget.member.session?.videoOpen ??
          context.read<RtcController>().videoOpen) &&
      !muted;

  void handleToggleMute() {
    widget.member.session?.muted = !muted;
  }

  @override
  Widget build(BuildContext context) {
    final member = widget.member;
    final controller = context.watch<RtcController>();

    final renderer = member.session?.renderer ?? controller.renderer;

    return ListenableBuilder(
      listenable: Listenable.merge([
        controller,
        member.session,
      ]),
      builder: (context, _) => MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (e) {
          setState(() {
            menuOpen = true;
          });
        },
        onExit: (e) {
          setState(() {
            menuOpen = false;
          });
        },
        child: GestureDetector(
          onTap: () {
            if (_timer != null) {
              _timer?.cancel();
              _timer = null;
              setState(() {
                menuOpen = false;
              });
              return;
            }
            debugPrint('focus stream');
          },
          onLongPress: () {
            if (menuOpen) return;

            setState(() {
              menuOpen = true;
            });
            _timer = Timer(const Duration(seconds: 5), () {
              setState(() {
                menuOpen = false;
              });
            });
          },
          child: Stack(
            children: [
              AccountAvatar(snapshot: member.snapshot).positioned(
                left: 12,
                top: 12,
              ),
              if (videoOpen)
                Positioned.fill(
                  child: RTCVideoView(
                    renderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  ),
                ),
              Icon(
                audioOpen ? Icons.mic : Icons.mic_off,
                color: Colors.black38,
              ).positioned(left: 12, bottom: 12),
              if (member.session != null)
                FloatingActionButton.small(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48),
                  ),
                  heroTag: member.clientId,
                  onPressed: handleToggleMute,
                  child: Icon(
                    Icons.block,
                    color: muted ? Colors.red : Colors.grey,
                  ),
                )
                    .positioned(
                      right: menuOpen ? 12 : -144,
                      bottom: 12,
                      animate: true,
                    )
                    .animate(Durations.medium1, Curves.easeIn),
              const Icon(
                Icons.block,
                size: 96,
                color: Colors.red,
              )
                  .opacity(muted ? 0.5 : 0, animate: true)
                  .animate(Durations.medium1, Curves.easeIn)
                  .center(),
            ],
          )
              .backgroundColor(Colors.black54)
              .clipRRect(all: 16, clipBehavior: Clip.hardEdge),
        ),
      ),
    );
  }
}
