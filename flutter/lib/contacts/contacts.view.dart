import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/contacts/search/search.view.dart';
import 'package:sheason_chat/contacts/tabs/contact_tab.view.dart';
import 'package:sheason_chat/contacts/tabs/group_tab.view.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:styled_widget/styled_widget.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  toSearch(BuildContext context) {
    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.add(const SearchContactPage());
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('联系人'),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                const Text(
                  '联系人',
                  overflow: TextOverflow.ellipsis,
                ).padding(vertical: 6),
                const Text(
                  '群聊',
                  overflow: TextOverflow.ellipsis,
                ).padding(vertical: 6),
              ],
            ),
            const TabBarView(
              children: [
                ContactsTab(),
                GroupsTab(),
              ],
            ).expanded(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: const ValueKey('search contact'),
        onPressed: () => toSearch(context),
        child: const Icon(Icons.search),
      ),
    );
  }
}
