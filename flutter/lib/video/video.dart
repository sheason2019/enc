import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

enum _VideoResourceType {
  network,
  file,
}

class SimpleVideo extends StatefulWidget {
  final _VideoResourceType _type;
  final String? url;
  final XFile? file;

  const SimpleVideo._({
    required _VideoResourceType type,
    this.url,
    this.file,
  }) : _type = type;

  factory SimpleVideo.network(String url) {
    return SimpleVideo._(
      type: _VideoResourceType.network,
      url: url,
    );
  }

  factory SimpleVideo.file(XFile file) {
    return SimpleVideo._(
      type: _VideoResourceType.file,
      file: file,
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
        if (!kIsWeb) {
          await player.open(
            Media('file:///${widget.file!.path}'),
            play: false,
          );
        } else {
          await player.open(
            await Media.memory(await widget.file!.readAsBytes()),
            play: false,
          );
        }
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
    return AspectRatio(
      aspectRatio: aspect,
      child: Video(
        controller: controller,
      ),
    );
  }
}
