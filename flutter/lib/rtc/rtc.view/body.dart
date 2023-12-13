import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/accounts/account_avatar.view.dart';
import 'package:sheason_chat/rtc/rtc.controller.dart';
import 'package:sheason_chat/rtc/rtc.model/session.dart';

class RtcPageBody extends StatelessWidget {
  const RtcPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RtcController>();
    final clientMap = controller.clientMap;
    final clients = clientMap.keys.toList();

    return ListView.builder(
      itemCount: clients.length,
      itemBuilder: (context, index) => ListTile(
        leading: AccountAvatar(
          snapshot: clientMap[clients[index]]!.snapshot,
        ),
        title: Text(clients[index]),
        trailing: DelayBuilder(
          session: clientMap[clients[index]]!.session,
        ),
      ),
    );
  }
}

class DelayBuilder extends StatelessWidget {
  final RtcSession? session;
  const DelayBuilder({super.key, required this.session});

  Color colorBuilder(int delay) {
    if (delay < 0) return Colors.red;
    if (delay < 100) return Colors.green;
    if (delay < 500) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final session = this.session;
    if (session == null) {
      return const SizedBox();
    }

    return ListenableBuilder(
      listenable: session,
      builder: (context, _) => Text(
        '${session.delay} ms',
        style: TextStyle(color: colorBuilder(session.delay)),
      ),
    );
  }
}
