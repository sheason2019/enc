import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
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
  final subList = <StreamSubscription>[];
  final player = Player();

  var playing = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  late final message = context.read<Message>();
  late final resource = NetworkResource.fromJson(jsonDecode(message.content));

  Future<void> handlePlay() async {
    if (playing) {
      player.pause();
    } else {
      player.play();
    }
  }

  Future<void> watchState() async {
    final subPlay = player.stream.playing.listen((event) {
      if (event != playing) {
        setState(() {
          playing = event;
        });
      }
    });
    subList.add(subPlay);

    final subPosition = player.stream.position.listen((event) {
      setState(() {
        position = event;
      });
    });
    subList.add(subPosition);

    final subDuration = player.stream.duration.listen((event) {
      setState(() {
        duration = event;
      });
    });
    subList.add(subDuration);

    final subComplete = player.stream.completed.listen((event) async {
      if (event) {
        await player.pause();
        await player.seek(Duration.zero);
      }
    });
    subList.add(subComplete);

    await player.open(Media(resource.url), play: false);
  }

  @override
  void initState() {
    watchState();
    super.initState();
  }

  @override
  void dispose() {
    for (final sub in subList) {
      sub.cancel();
    }
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
