import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:sheason_chat/utils/service_selector/service_selector.controller.dart';
import 'package:sheason_chat/utils/service_selector/service_selector.view.dart';
import 'package:sheason_chat/utils/string_helper.dart';
import 'package:styled_widget/styled_widget.dart';

class FileInputView extends StatefulWidget {
  final Scope scope;
  final String filePath;
  const FileInputView({
    super.key,
    required this.scope,
    required this.filePath,
  });

  @override
  State<StatefulWidget> createState() => _FileInputViewState();
}

class _FileInputViewState extends State<FileInputView> {
  late final serviceController = ServiceSelectorController(widget.scope);

  @override
  void dispose() {
    serviceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('发送文件'),
      contentPadding: const EdgeInsets.all(20),
      children: [
        ListTile(
          leading: const Icon(Icons.file_present_rounded),
          title: Text(path.basename(widget.filePath)),
          subtitle: FutureBuilder(
            initialData: 0,
            future: File(widget.filePath).length(),
            builder: (context, snapshot) => Text(
              StringHelper.fileSize(snapshot.requireData),
            ),
          ),
        ),
        ServiceSelector(controller: serviceController),
        TextButton(
          onPressed: () => Navigator.of(context).pop(
            serviceController.serviceUrl,
          ),
          child: const Text('确认发送'),
        ).padding(top: 12),
      ],
    );
  }
}
