import 'package:flutter/material.dart';
import 'package:ENC/accounts/account_avatar.view.dart';
import 'package:ENC/rtc/rtc.model/member.dart';
import 'package:ENC/rtc/rtc.model/session.dart';

class MemberListTile extends StatelessWidget {
  final RtcMember member;
  const MemberListTile({
    super.key,
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AccountAvatar(
        snapshot: member.snapshot,
      ),
      title: Text(member.clientId),
      trailing: _DelayBuilder(
        session: member.session,
      ),
    );
  }
}

class _DelayBuilder extends StatelessWidget {
  final RtcSession? session;
  const _DelayBuilder({super.key, required this.session});

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
