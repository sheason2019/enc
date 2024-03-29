import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:ENC/dio.dart';
import 'package:ENC/models/network_resource.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:ENC/utils/string_helper.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FileMessageController extends ChangeNotifier {
  final Scope scope;
  final NetworkResource resource;
  FileMessageController({required this.scope, required this.resource}) {
    checkCached();
  }

  var cached = false;

  String get filePath => path.join(
        scope.paths.cache,
        '${Uri.encodeComponent(resource.url)}.${resource.name}',
      );

  // 监听缓存文件是否存在的 Stream
  Future<void> checkCached() async {
    if (kIsWeb) return;

    final cached = await File(filePath).exists();
    if (cached != this.cached) {
      this.cached = cached;
      notifyListeners();
    }
  }

  Future<String> fileSize() async {
    if (cached) {
      final size = await File(filePath).length();
      return StringHelper.fileSize(size);
    }

    try {
      final resp = await dio.get('${resource.url}/size');
      final size = int.parse(resp.data);
      return StringHelper.fileSize(size);
    } catch (e) {
      return 'Unknown';
    }
  }

  var progress = 0.0;

  // 点击下载文件
  Future<void> download() async {
    if (kIsWeb) {
      await launchUrlString('${resource.url}?name=${resource.name}');
      return;
    } else {
      await dio.download(
        resource.url,
        filePath,
        onReceiveProgress: (count, total) {
          progress = total / count;
          notifyListeners();
        },
      );
      await checkCached();
    }
  }

  // 点击打开文件
  openFile() {
    OpenFile.open(filePath);
  }
}
