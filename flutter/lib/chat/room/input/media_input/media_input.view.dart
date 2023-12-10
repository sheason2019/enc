import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:sheason_chat/video/video.dart';
import 'package:styled_widget/styled_widget.dart';

import 'media_input.controller.dart';
import 'media_input.model.dart';

class MediaInputView extends StatefulWidget {
  final Scope scope;
  final MediaInputContext mediaInputContext;
  const MediaInputView({
    super.key,
    required this.scope,
    required this.mediaInputContext,
  });

  @override
  State<StatefulWidget> createState() => _MediaInputViewState();
}

class _MediaInputViewState extends State<MediaInputView> {
  String get mediaName {
    switch (widget.mediaInputContext.mediaType) {
      case MediaType.image:
        return '图片';
      case MediaType.video:
        return '视频';
    }
  }

  Widget contentBuilder(BuildContext context) {
    switch (widget.mediaInputContext.mediaType) {
      case MediaType.image:
        return _PreviewImage(mediaInputContext: widget.mediaInputContext);
      case MediaType.video:
        return _PreviewVideo(mediaInputContext: widget.mediaInputContext);
    }
  }

  String? serviceUrl;

  @override
  Widget build(BuildContext context) {
    final services = widget.scope.snapshot.serviceMap.keys.toList();

    return SimpleDialog(
      title: Text('发送$mediaName'),
      contentPadding: const EdgeInsets.all(20),
      children: [
        contentBuilder(context),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: DropdownButton<String>(
            isExpanded: true,
            value: serviceUrl,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            hint: const Text('点击选择托管静态资源的服务器'),
            onChanged: (v) {
              setState(() {
                serviceUrl = v;
              });
            },
            items: [
              for (final service in services)
                DropdownMenuItem(
                  value: service,
                  child: Text(service),
                ),
            ],
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(serviceUrl),
          child: const Text('确认发送'),
        ).padding(top: 12),
      ],
    );
  }
}

class _PreviewImage extends StatelessWidget {
  final MediaInputContext mediaInputContext;
  const _PreviewImage({
    required this.mediaInputContext,
  });

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.file(
      File(mediaInputContext.mediaFile.path),
      fit: BoxFit.contain,
    ).constrained(maxWidth: 360);
  }
}

class _PreviewVideo extends StatelessWidget {
  final MediaInputContext mediaInputContext;
  const _PreviewVideo({
    required this.mediaInputContext,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleVideo.file(mediaInputContext.mediaFile.path).width(360);
  }
}
