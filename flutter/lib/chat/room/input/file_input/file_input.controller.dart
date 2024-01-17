import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ENC/chat/room/input/file_input/file_input.view.dart';
import 'package:ENC/scope/scope.model.dart';

class FileInputController {
  final BuildContext context;
  const FileInputController({required this.context});

  Future<XFile?> pickFile() async {
    final picker = await FilePicker.platform.pickFiles();
    if (picker == null) return null;

    final f = picker.files.first;

    return XFile.fromData(
      f.bytes!,
      name: f.name,
      path: kIsWeb ? null : f.path,
    );
  }

  Future<String?> showPreviewDialog(XFile file) {
    return showDialog<String>(
      context: context,
      builder: (context) => FileInputView(
        scope: context.read<Scope>(),
        file: file,
      ),
    );
  }
}
