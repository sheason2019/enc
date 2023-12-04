import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/contacts/detail/detail.view.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class ContactsTab extends StatelessWidget {
  const ContactsTab({super.key});

  Stream<List<int>> fetchStream(BuildContext context) {
    final scope = context.watch<Scope>();
    final select = scope.db.contacts.selectOnly();
    select.addColumns([scope.db.contacts.id]);
    return select
        .watch()
        .map((e) => e.map((e) => e.read(scope.db.contacts.id)!).toList());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: const [],
      stream: fetchStream(context),
      builder: (context, snapshot) {
        final list = snapshot.data ?? [];

        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) => ContactListTile(id: list[index]),
        );
      },
    );
  }
}

class ContactListTile extends StatelessWidget {
  final int id;
  const ContactListTile({super.key, required this.id});

  Future<Contact> fetchContact(BuildContext context) {
    final scope = context.watch<Scope>();
    final select = scope.db.contacts.select();
    select.where((tbl) => tbl.id.equals(id));
    return select.getSingle();
  }

  handleClick(BuildContext context, AccountSnapshot snapshot) {
    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.add(ContactDetailPage(snapshot: snapshot));
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchContact(context),
      builder: (context, snapshot) {
        var account = AccountSnapshot();
        if (snapshot.hasData) {
          account = snapshot.data!.snapshot;
        }

        return ListTile(
          onTap: () => handleClick(context, account),
          leading: const CircleAvatar(),
          title: Text(
            account.username,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            account.index.signPubKey,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }
}
