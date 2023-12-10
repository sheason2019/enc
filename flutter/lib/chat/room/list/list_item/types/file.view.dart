import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/list/list_item/wrapper.view.dart';
import 'package:sheason_chat/dio.dart';
import 'package:sheason_chat/models/network_resource.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/utils/string_helper.dart';
import 'package:styled_widget/styled_widget.dart';

class FileMessageView extends StatelessWidget {
  const FileMessageView({super.key});

  Future<String> fileSize(String url) async {
    try {
      final resp = await dio.get('$url/size');
      final size = int.parse(resp.data);
      return StringHelper.fileSize(size);
    } catch (e) {
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final message = context.watch<Message>();

    final resource = NetworkResource.fromJson(jsonDecode(message.content));

    return MessageListItemWrapperView(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.file_present_rounded,
            size: 36,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                resource.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FutureBuilder(
                initialData: 'loading',
                future: fileSize(resource.url),
                builder: (context, snapshot) => Text(
                  snapshot.requireData,
                ),
              ),
            ],
          ).padding(left: 12, right: 8),
        ],
      )
          .constrained(maxWidth: 360)
          .padding(all: 12)
          .backgroundColor(Colors.white),
    );
  }
}
