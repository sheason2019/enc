import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/chat/room/messages/message/wrapper.view.dart';
import 'package:ENC/main.controller.dart';
import 'package:ENC/models/rtc_model.dart';
import 'package:ENC/rtc/rtc.view.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class RtcMessageView extends StatelessWidget {
  const RtcMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    final message = context.watch<Message>();
    final rtcModel = RtcModel.fromJson(jsonDecode(message.content));

    return MessageListItemWrapperView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '通话邀请',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
              .padding(left: 16)
              .alignment(Alignment.centerLeft)
              .height(36)
              .backgroundColor(Colors.green),
          TextButton(
            onPressed: () {
              final delegate = context.read<MainController>().rootDelegate;
              delegate.pages.add(RtcPage(
                scope: context.read<Scope>(),
                rtcModel: rtcModel,
              ));
              delegate.notify();
            },
            child: const Text('加入通话'),
          ).padding(vertical: 4, right: 8).alignment(Alignment.centerRight),
        ],
      ).width(210).backgroundColor(Colors.white),
    );
  }
}
