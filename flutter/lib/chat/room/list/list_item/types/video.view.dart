import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/list/list_item/wrapper.view.dart';
import 'package:sheason_chat/models/network_resource.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/video/video.dart';
import 'package:styled_widget/styled_widget.dart';

class VideoMessageView extends StatelessWidget {
  const VideoMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    final message = context.watch<Message>();
    final isDesktop =
        Platform.isWindows || Platform.isMacOS || Platform.isLinux;

    final networkResource = NetworkResource.fromJson(
      jsonDecode(message.content),
    );

    return MessageListItemWrapperView(
      child: SimpleVideo.network(networkResource.url).constrained(
        minWidth: isDesktop ? 400 : 280,
        maxWidth: isDesktop ? 400 : 280,
        maxHeight: isDesktop ? 400 : 280,
      ),
    );
  }
}
