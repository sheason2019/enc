import 'package:flutter/material.dart';
import 'package:ENC/rtc/member_list_tile/member_list_tile.view.dart';
import 'package:ENC/rtc/rtc.controller.dart';

class RtcMemberListPage extends StatelessWidget {
  final RtcController controller;
  const RtcMemberListPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final clientMap = controller.clientMap;
    final clients = clientMap.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('成员列表'),
      ),
      body: ListView.builder(
        itemCount: clients.length,
        itemBuilder: (context, index) => MemberListTile(
          member: clientMap[clients[index]]!,
        ),
      ),
    );
  }
}
