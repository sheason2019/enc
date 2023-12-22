import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/chat/room/messages/message/wrapper.view.dart';
import 'package:ENC/models/network_resource.dart';
import 'package:ENC/schema/database.dart';
import 'package:styled_widget/styled_widget.dart';

class ImageMessageView extends StatelessWidget {
  const ImageMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    final message = context.watch<Message>();

    final networkResource = NetworkResource.fromJson(
      jsonDecode(message.content),
    );

    return MessageListItemWrapperView(
      child: ExtendedImage.network(
        networkResource.url,
      ).constrained(maxWidth: 240, minHeight: 48),
    );
  }
}
