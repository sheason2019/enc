import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/list/list_item/wrapper.view.dart';
import 'package:sheason_chat/models/network_resource.dart';
import 'package:sheason_chat/schema/database.dart';
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
      child: ExtendedImage.network(networkResource.url).constrained(
        maxWidth: 360,
      ),
    );
  }
}
