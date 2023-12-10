import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'media_input.controller.dart';

@immutable
class MediaInputContext {
  final MediaType mediaType;
  final XFile mediaFile;

  const MediaInputContext({
    required this.mediaFile,
    required this.mediaType,
  });
}
