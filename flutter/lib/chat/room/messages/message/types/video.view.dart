import 'dart:convert';

import 'package:ENC/utils/breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/chat/room/messages/message/wrapper.view.dart';
import 'package:ENC/models/network_resource.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/video/video.dart';
import 'package:styled_widget/styled_widget.dart';

class VideoMessageView extends StatelessWidget {
  const VideoMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    final message = context.watch<Message>();
    final bp = context.watch<BreakPoint>();
    final lg = bp == BreakPoint.lg;

    final networkResource = NetworkResource.fromJson(
      jsonDecode(message.content),
    );

    return MessageListItemWrapperView(
      child: SimpleVideo.network(networkResource.url).constrained(
        minWidth: lg ? 400 : 280,
        maxWidth: lg ? 400 : 280,
        maxHeight: lg ? 400 : 280,
      ),
    );
  }
}
