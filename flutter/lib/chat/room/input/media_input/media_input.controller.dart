import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/input/media_input/media_input.model.dart';
import 'package:sheason_chat/scope/scope.model.dart';

import 'media_input.view.dart';

enum MediaType {
  image,
  video,
}

class MediaInputController {
  final BuildContext context;
  const MediaInputController({required this.context});

  Future<MediaInputContext?> selectMedia() async {
    final picker = ImagePicker();
    final media = await picker.pickMedia();
    if (media == null) {
      return null;
    }

    final mediaType = parseMediaType(media.name);
    return MediaInputContext(
      mediaFile: media,
      mediaType: mediaType,
    );
  }

  // 根据文件后缀名获取文件类型
  MediaType parseMediaType(String filename) {
    final imageReg = RegExp(r'^.+\.(jpg|png|gif|bmp|jpeg)$');
    if (imageReg.hasMatch(filename)) {
      return MediaType.image;
    }

    final videoReg = RegExp(r'^.+\.(mp4|mov|wmv|flv|avi)$');
    if (videoReg.hasMatch(filename)) {
      return MediaType.video;
    }

    throw Exception('Unknown media type $filename');
  }

  Future<String?> showPreviewDialog(MediaInputContext mediaInputContext) {
    return showDialog<String>(
      context: context,
      builder: (context) => MediaInputView(
        scope: context.read<Scope>(),
        mediaInputContext: mediaInputContext,
      ),
    );
  }
}
