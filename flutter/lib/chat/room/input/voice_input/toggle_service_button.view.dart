import 'package:flutter/material.dart';

import 'voice_input.controller.dart';

class ToggleServiceButton extends StatelessWidget {
  final VoiceInputController controller;
  const ToggleServiceButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => controller.handleToggleService(context),
      icon: const Icon(Icons.settings),
    );
  }
}
