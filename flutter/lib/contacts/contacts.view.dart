import 'package:ENC/router/base_delegate_wrapper.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:ENC/utils/breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/contacts/search/search.view.dart';
import 'package:ENC/contacts/tabs/contact_tab.view.dart';
import 'package:ENC/contacts/tabs/group_tab.view.dart';
import 'package:styled_widget/styled_widget.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();
    final bp = context.watch<BreakPoint>();

    if (bp == BreakPoint.lg) {
      return Row(
        children: [
          const _ContactView().width(360),
          const VerticalDivider(
            width: 1,
            color: Colors.black12,
          ),
          BaseDelegateWrapper(
            delegate: scope.router.contactDelegate,
            child: const Scaffold(),
          ).expanded(),
        ],
      );
    }

    return const _ContactView();
  }
}

class _ContactView extends StatelessWidget {
  const _ContactView();

  toSearch(BuildContext context) {
    final delegate = context.read<Scope>().router.contactDelegate;
    delegate.pages.add(const SearchContactPage());
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '联系人',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
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
