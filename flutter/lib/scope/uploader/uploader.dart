import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:sheason_chat/cyprto/crypto_utils.dart';
import 'package:sheason_chat/dio.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class Uploader {
  final Scope scope;
  Uploader({required this.scope});

  // 上传加密内容
  Future<String> upload(
    String serviceUrl,
    String filePath,
  ) async {
    final url = '$serviceUrl/${scope.secret.signPubKey}/storage';
    // 文件上传功能
    const blockSize = 512 * 1024;

    final f = File(filePath);
    final file = await f.open(mode: FileMode.read);
    final fileSize = await f.length();
    final blockCount = (fileSize / blockSize).ceil();

    final chunkList = <String>[];

    for (var block = 0; block < blockCount; block++) {
      final readLength = math.min(blockSize, fileSize - block * blockSize);
      final data = await file.read(readLength);
      final signature = await CryptoUtils.createSignature(
        scope,
        data,
      );
      final wrapper = SignWrapper()
        ..buffer = data
        ..sign = signature.bytes
        ..signer = scope.snapshot.index
        ..contentType = ContentType.CONTENT_BUFFER;

      final formData = FormData.fromMap({
        'type': 'upload',
        'payload': base64Encode(wrapper.writeToBuffer()),
      });

      final resp = await dio.post(
        url,
        data: formData,
      );
      chunkList.add(resp.data);
    }

    // 如果只上传了单文件，则直接返回单文件ID
    if (chunkList.length == 1) {
      await file.close();
      return '$url/${chunkList.first}';
    }

    final mergeData = jsonEncode(chunkList).codeUnits;
    final mergeSignature = await CryptoUtils.createSignature(
      scope,
      mergeData,
    );
    final mergeWrapper = SignWrapper()
      ..buffer = mergeData
      ..sign = mergeSignature.bytes
      ..signer = scope.snapshot.index
      ..contentType = ContentType.CONTENT_BUFFER;

    final resp = await dio.post(
      url,
      data: FormData.fromMap({
        'type': 'merge',
        'payload': mergeWrapper.writeToBuffer(),
      }),
    );
    final fileId = resp.data.toString();

    // 清理 Chunk 文件以降低资源占用
    await dio.post(
      url,
      data: FormData.fromMap({
        'type': 'delete',
        'payload': base64UrlEncode(mergeWrapper.writeToBuffer()),
      }),
    );

    await file.close();
    return '$url/$fileId';
  }
}
