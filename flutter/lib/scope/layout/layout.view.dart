import 'package:ENC/accounts/online_hint/scope_online_hint.view.dart';
import 'package:ENC/router/base_delegate_wrapper.dart';
import 'package:ENC/scope/layout/account_collection_entry/account_collection_entry.view.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:ENC/utils/breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class ScopeLayout extends StatelessWidget {
  final Widget child;
  const ScopeLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();
    final bp = context.watch<BreakPoint>();

    if (bp == BreakPoint.lg) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              leading: Column(
                children: [
                  const AccountCollectionEntry(),
                  ScopeOnlineHint(scope: scope).padding(top: 4),
                ],
              ),
              labelType: NavigationRailLabelType.all,
              selectedIndex: scope.router.tabIndex,
              onDestinationSelected: (value) {
                scope.router.tabIndex = value;
              },
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.chat),
                  label: Text('消息'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.people),
                  label: Text('联系人'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.account_circle),
                  label: Text('档案'),
                ),
              ],
            ),
            const VerticalDivider(
              width: 1,
              color: Colors.black12,
            ),
            child.expanded(),
          ],
        ),
      );
    }

    return MultiBaseDelegateWrapper(
      delegates: [
        scope.router.chatDelegate,
        scope.router.contactDelegate,
        scope.router.profileDelegate,
      ],
      child: Scaffold(
        body: child,
        bottomNavigationBar: NavigationBar(
          selectedIndex: scope.router.tabIndex,
          onDestinationSelected: (v) {
            scope.router.tabIndex = v;
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.chat),
              label: '消息',
            ),
            NavigationDestination(
              icon: Icon(Icons.people),
              label: '联系人',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_circle),
              label: '档案',
            ),
          ],
        ),
      ),
    );
  }
}
