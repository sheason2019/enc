import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/list/list_item/wrapper.view.dart';
import 'package:sheason_chat/models/network_resource.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class AudioMessageView extends StatefulWidget {
  const AudioMessageView({super.key});

  @override
  State<StatefulWidget> createState() => _AudioMessageViewState();
}

class _AudioMessageViewState extends State<AudioMessageView> {
  final player = AudioPlayer();

  var playing = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  late final message = context.read<Message>();
  late final resource = NetworkResource.fromJson(jsonDecode(message.content));
  late final source = UrlSource(resource.url);

  Future<void> handlePlay() async {
    debugPrint(source.url);
    await player.play(source);
  }

  Future<void> watchState() async {
    player.onPlayerStateChanged.listen((event) {
      final playing = event == PlayerState.playing;
      if (playing != this.playing) {
        setState(() {
          this.playing = playing;
        });
      }
    });
    player.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
    player.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });
  }

  @override
  void initState() {
    watchState();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();
    final contact = context.watch<Contact>();

    final isCurrentAccountSend = contact.signPubkey == scope.secret.signPubKey;

    var progress = 0.0;
    final d = duration.inMilliseconds;
    final p = position.inMilliseconds;

    if (d != 0) {
      progress = p / d;
    }

    final remain = duration - position;

    return MessageListItemWrapperView(
      child: GestureDetector(
        onTap: handlePlay,
        // TODO: 添加滑动控制音频进度功能
        // onPanStart: (details) {
        //   debugPrint('change progress start');
        // },
        // onPanUpdate: (details) {
        //   debugPrint('change progress update');
        // },
        // onPanEnd: (details) {
        //   debugPrint('change progress end');
        // },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                playing ? Icons.pause_circle : Icons.play_circle,
                size: 36,
                color: isCurrentAccountSend
                    ? Colors.white.withOpacity(0.9)
                    : Colors.black,
              ),
              LinearProgressIndicator(value: progress)
                  .width(144)
                  .padding(horizontal: 12),
              Text(
                '${remain.inSeconds} s',
                style: TextStyle(
                  color: isCurrentAccountSend ? Colors.white : Colors.black,
                ),
              ).padding(right: 8),
            ],
          ).constrained(maxWidth: 360).padding(horizontal: 12, vertical: 10),
        ),
      ),
    );
  }
}
