import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ENC/chat/room/input/voice_input/voice_input.controller.dart';
import 'package:styled_widget/styled_widget.dart';

class VoiceInputOverlay extends StatefulWidget {
  final VoiceInputController controller;
  const VoiceInputOverlay({
    super.key,
    required this.controller,
  });

  @override
  State<StatefulWidget> createState() => _VoiceInputOverlayState();
}

class _VoiceInputOverlayState extends State<VoiceInputOverlay> {
  final key = GlobalKey();
  var open = false;

  initCancelArea() {
    final context = key.currentContext;
    final renderBox = context?.findRenderObject() as RenderBox?;
    final offset = renderBox?.localToGlobal(Offset.zero);
    final size = renderBox?.paintBounds.size;
    if (offset != null && size != null) {
      final rect = Rect.fromPoints(
        offset,
        Offset(offset.dx + size.width, offset.dy + size.height),
      );
      widget.controller.cancelRect = rect;
    }
  }

  initClose() async {
    final closeSignal = Completer();
    widget.controller.closeSignal = closeSignal;
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        open = true;
      });
    });
    closeSignal.future.then((value) {
      setState(() {
        open = false;
      });
      Timer(Durations.short3, () {
        widget.controller.entry?.remove();
      });
    });
  }

  @override
  void initState() {
    initClose();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      initCancelArea();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          ListenableBuilder(
            listenable: widget.controller,
            builder: (context, _) {
              final cancel = widget.controller.cancel;
              return Icon(
                CupertinoIcons.trash,
                color: cancel ? Colors.white : Colors.grey,
                size: 64,
              )
                  .backgroundColor(
                    cancel ? Colors.red : Colors.white,
                    animate: true,
                  )
                  .animate(Durations.short3, Curves.linear)
                  .opacity(open ? 1 : 0, animate: true)
                  .animate(Durations.short3, Curves.linear)
                  .width(144)
                  .height(144)
                  .clipRRect(all: 144, key: key)
                  .center()
                  .positioned(bottom: 144, left: 0, right: 0);
            },
          ),
        ],
      ),
    )
        .backgroundColor(
          open ? Colors.black45 : Colors.transparent,
          animate: true,
        )
        .animate(Durations.short3, Curves.linear)
        .backgroundBlur(2);
  }
}
