import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/models/rtc_model.dart';
import 'package:sheason_chat/rtc/rtc.controller.dart';
import 'package:sheason_chat/rtc/rtc.view/body.dart';
import 'package:sheason_chat/rtc/rtc.view/control.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class RtcPage extends StatelessWidget {
  final Scope scope;
  final RtcModel rtcModel;
  const RtcPage({super.key, required this.scope, required this.rtcModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RTC Page'),
      ),
      body: ListenableProvider(
        create: (context) => RtcController(
          model: rtcModel,
          scope: scope,
        )..connect(),
        dispose: (context, value) => value.dispose(),
        builder: (context, index) => Column(
          children: [
            const RtcPageBody().expanded(),
            const RtcPageControl(),
          ],
        ),
      ),
    );
  }
}
