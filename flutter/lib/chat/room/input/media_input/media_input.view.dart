import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:ENC/utils/service_selector/service_selector.controller.dart';
import 'package:ENC/utils/service_selector/service_selector.view.dart';
import 'package:ENC/video/video.dart';
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
  late final serviceController = ServiceSelectorController(widget.scope);

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

  @override
  void dispose() {
    serviceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('发送$mediaName'),
      contentPadding: const EdgeInsets.all(20),
      children: [
        contentBuilder(context),
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

class _PreviewImage extends StatelessWidget {
  final MediaInputContext mediaInputContext;
  const _PreviewImage({
    required this.mediaInputContext,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mediaInputContext.mediaFile.readAsBytes(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }
        return ExtendedImage.memory(
          snapshot.requireData,
          fit: BoxFit.contain,
        );
      },
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
