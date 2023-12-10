import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

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

  Future<void> initVideo() async {
    switch (widget._type) {
      case _VideoResourceType.file:
        player.open(Media('file:///${widget.filePath}'), play: false);
        break;
      case _VideoResourceType.network:
        player.open(Media(widget.url!), play: false);
        break;
    }
  }

  @override
  void initState() {
    initVideo();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Video(controller: controller),
    );
  }
}
