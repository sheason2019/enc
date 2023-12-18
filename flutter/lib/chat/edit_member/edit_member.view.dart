import 'package:flutter/material.dart';
import 'package:sheason_chat/chat/edit_member/edit_member.controller.dart';
import 'package:sheason_chat/chat/edit_member/list_tile/list_tile.view.dart';

class EditMemberView extends StatelessWidget {
  final EditMemberController controller;
  const EditMemberView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('编辑成员'),
      ),
      body: StreamBuilder<List<int>>(
        initialData: const [],
        stream: controller.createContactStream(),
        builder: (context, snapshot) => ListenableBuilder(
          listenable: controller,
          builder: (context, _) => ListView.builder(
            itemCount: snapshot.requireData.length,
            itemBuilder: (context, index) => EditMemberListTile(
              controller: controller,
              id: snapshot.requireData[index],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.memberSet.clear();
          controller.memberSet.addAll(controller.selectSet);
          controller.notify();
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}