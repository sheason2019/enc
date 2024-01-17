import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/chat/room/messages/message/types/file/file.controller.dart';
import 'package:ENC/chat/room/messages/message/wrapper.view.dart';
import 'package:ENC/models/network_resource.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class FileMessageView extends StatefulWidget {
  const FileMessageView({super.key});

  @override
  State<StatefulWidget> createState() => _FileMessageViewState();
}

class _FileMessageViewState extends State<FileMessageView> {
  late final message = context.read<Message>();
  late final resource = NetworkResource.fromJson(
    jsonDecode(message.content),
  );
  late final controller = FileMessageController(
    scope: context.read<Scope>(),
    resource: resource,
  );

  @override
  Widget build(BuildContext context) {
    return MessageListItemWrapperView(
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, snapshot) => Material(
          child: InkWell(
            onTap: () {
              if (controller.cached) {
                controller.openFile();
              } else {
                controller.download();
              }
            },
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
                      future: controller.fileSize(),
                      builder: (context, snapshot) => Text(
                        snapshot.requireData,
                      ),
                    ),
                  ],
                ).padding(horizontal: 12).constrained(maxWidth: 240),
                if (controller.cached)
                  _FileOpenButton(controller: controller)
                else
                  _FileDownloadButton(controller: controller),
              ],
            ).constrained(maxWidth: 360).padding(all: 12),
          ),
        ),
      ),
    );
  }
}

class _FileDownloadButton extends StatelessWidget {
  final FileMessageController controller;
  const _FileDownloadButton({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Icon(
          Icons.download,
          size: 26,
        ).padding(all: 6),
        ListenableBuilder(
          listenable: controller,
          builder: (context, _) => CircularProgressIndicator(
            value: controller.progress,
            strokeWidth: 3,
          ).positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
          ),
        ),
      ],
    );
  }
}

class _FileOpenButton extends StatelessWidget {
  final FileMessageController controller;
  const _FileOpenButton({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.download_done,
      size: 26,
    ).padding(all: 6);
  }
}
