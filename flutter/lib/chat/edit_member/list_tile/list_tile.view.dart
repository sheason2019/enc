import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:sheason_chat/accounts/account_avatar.view.dart';
import 'package:sheason_chat/chat/edit_member/edit_member.controller.dart';
import 'package:sheason_chat/schema/database.dart';

class EditMemberListTile extends StatelessWidget {
  final EditMemberController controller;
  final int id;

  const EditMemberListTile({
    super.key,
    required this.id,
    required this.controller,
  });

  Future<Contact> findContact() {
    final db = controller.scope.db;
    final select = db.contacts.select();
    select.where((tbl) => tbl.id.equals(id));
    return select.getSingle();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: findContact(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        final contact = snapshot.requireData;

        void Function(bool?)? onChanged = (bool? value) {
          if (value == true) {
            controller.selectSet.add(contact.id);
          } else {
            controller.selectSet.remove(contact.id);
          }
          controller.notify();
        };
        if (controller.disableSet.contains(contact.id)) {
          onChanged = null;
        }

        return CheckboxListTile(
          value: controller.selectSet.contains(contact.id),
          onChanged: onChanged,
          secondary: AccountAvatar(snapshot: contact.snapshot),
          title: Text(contact.snapshot.username),
          subtitle: Text(contact.snapshot.index.signPubKey),
        );
      },
    );
  }
}
