import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:uuid/uuid.dart';

class VoiceInputController extends ChangeNotifier {
  final Scope scope;
  VoiceInputController({required this.scope});

  String get service => _service;
  set service(String value) {
    _service = value;
    notifyListeners();
  }

  final recorder = AudioRecorder();

  @override
  void dispose() {
    recorder.dispose();
    super.dispose();
  }

  var _service = '';

  Rect? cancelRect;

  bool get cancel => _cancel;
  set cancel(bool value) {
    _cancel = value;
    notifyListeners();
  }

  var _cancel = false;

  OverlayEntry? entry;
  Completer? closeSignal;
  void closeEntry() {
    closeSignal?.complete();
  }

  var recording = false;

  Future<void> startRecord() async {
    if (!await recorder.hasPermission()) {
      throw Exception('Permission denied');
    }
    final uuid = const Uuid().v4();
    final filePath = path.join(
      scope.paths.cache,
      '$uuid.wav',
    );

    final dirPath = path.dirname(filePath);
    final dir = Directory(dirPath);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    await recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.wav,
      ),
      path: filePath,
    );
  }

  Future<String?> stopRecord() async {
    return recorder.stop();
  }

  void handleToggleService(BuildContext context) {
    final scope = context.read<Scope>();
    final serviceMap = scope.snapshot.serviceMap;
    final services = serviceMap.keys.toList();

    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        children: [
          Text(
            '选择托管语音文件的服务器',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ).padding(vertical: 8),
          ListView.builder(
            itemCount: services.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                service = services[index];
                Navigator.of(context).pop();
              },
              title: Text(services[index]),
            ),
          ).expanded(),
        ],
      ),
    );
  }
}
