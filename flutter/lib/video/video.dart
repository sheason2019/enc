import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:styled_widget/styled_widget.dart';

enum _VideoResourceType {
  network,
  file,
}

class SimpleVideo extends StatefulWidget {
  final _VideoResourceType _type;
  final String? url;
  final String? filePath;

  const SimpleVideo._({
    required _VideoResourceType type,
    this.url,
    this.filePath,
  }) : _type = type;

  factory SimpleVideo.network(String url) {
    return SimpleVideo._(
      type: _VideoResourceType.network,
      url: url,
    );
  }

  factory SimpleVideo.file(String filePath) {
    return SimpleVideo._(
      type: _VideoResourceType.file,
      filePath: filePath,
    );
  }

  @override
  State<StatefulWidget> createState() => _SimpleVideoState();
}

class _SimpleVideoState extends State<SimpleVideo> {
  late final player = Player();
  late final controller = VideoController(player);
  late final subList = <StreamSubscription>[];

  Future<void> initVideo() async {
    switch (widget._type) {
      case _VideoResourceType.file:
        await player.open(Media('file:///${widget.filePath}'), play: false);
        break;
      case _VideoResourceType.network:
        await player.open(Media(widget.url!), play: false);
        break;
    }

    final subWidth = player.stream.width.listen((event) {
      setState(() {
        player.seek(Duration.zero);
      });
    });
    subList.add(subWidth);

    final subHeight = player.stream.height.listen((event) {
      setState(() {
        player.seek(Duration.zero);
      });
    });
    subList.add(subHeight);
  }

  @override
  void initState() {
    initVideo();
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

  double get aspect {
    final w = player.state.width;
    final h = player.state.height;
    if (w == null || h == null) return 1;
    return w / h;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop =
        Platform.isMacOS || Platform.isWindows || Platform.isLinux;

    return AspectRatio(
      aspectRatio: aspect,
      child: Video(
        controller: controller,
      ),
    ).constrained(minWidth: isDesktop ? 400 : 120);
  }
}
