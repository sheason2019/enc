import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:ENC/utils/service_selector/service_selector.controller.dart';
import 'package:ENC/utils/service_selector/service_selector.view.dart';
import 'package:ENC/utils/string_helper.dart';
import 'package:styled_widget/styled_widget.dart';

class FileInputView extends StatefulWidget {
  final Scope scope;
  final XFile file;
  const FileInputView({
    super.key,
    required this.scope,
    required this.file,
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
          title: Text(path.basename(widget.file.name)),
          subtitle: FutureBuilder(
            initialData: 0,
            future: widget.file.length(),
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
