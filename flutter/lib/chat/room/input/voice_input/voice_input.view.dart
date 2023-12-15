import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/input/menu.view.dart';
import 'package:sheason_chat/chat/room/input/voice_input/voice_input.controller.dart';
import 'package:sheason_chat/chat/room/input/voice_input/voice_input_body.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

import 'toggle_service_button.view.dart';

class VoiceInputView extends StatefulWidget {
  const VoiceInputView({super.key});
  @override
  State<StatefulWidget> createState() => _VoiceInputViewState();
}

class _VoiceInputViewState extends State<VoiceInputView> {
  late final controller = VoiceInputController(
    scope: context.read<Scope>(),
  );

  @override
  void initState() {
    controller.recorder.hasPermission();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const InputMenuIconButton(),
          VoiceInputBody(
            controller: controller,
          ).expanded(),
          ToggleServiceButton(controller: controller),
        ],
      ),
    ).padding(all: 6).border(top: 1, color: Colors.black12);
  }
}
