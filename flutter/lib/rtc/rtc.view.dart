import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/models/rtc_model.dart';
import 'package:sheason_chat/rtc/member_media_card/member_media_card.view.dart';
import 'package:sheason_chat/rtc/rtc.controller.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

import 'control/control.view.dart';

class RtcPage extends StatelessWidget {
  final Scope scope;
  final RtcModel rtcModel;
  const RtcPage({super.key, required this.scope, required this.rtcModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('通话'),
      ),
      body: ListenableProvider(
          create: (context) => RtcController(
                model: rtcModel,
                scope: scope,
              )..connect(),
          dispose: (context, value) => value.dispose(),
          builder: (context, index) {
            final controller = context.watch<RtcController>();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: GridView.extent(
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    maxCrossAxisExtent: 400,
                    childAspectRatio: 16 / 9,
                    children: [
                      for (final member in controller.clientMap.values)
                        MemberMediaCard(member: member)
                    ],
                  ),
                ).expanded(),
                const RtcPageControl(),
              ],
            );
          }),
    );
  }
}
