import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/contacts/contacts.view.dart';
import 'package:sheason_chat/scope/scope.collection.dart';
import 'package:sheason_chat/chat/chat.view.dart';
import 'package:sheason_chat/profile/profile.view.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class ScopePage extends StatefulWidget {
  final Scope scope;
  const ScopePage({super.key, required this.scope});

  @override
  State<StatefulWidget> createState() => _ScopePageState();
}

class _ScopePageState extends State<ScopePage> {
  var tabIndex = 0;

  handleSetDefaultScope(BuildContext context) async {
    final controller = context.read<ScopeCollection>();
    await controller.setDefaultScope(widget.scope);
  }

  @override
  void initState() {
    handleSetDefaultScope(context);
    super.initState();
  }

  DateTime? _backedAt;

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope?>();
    if (scope == null) {
      return const Scaffold();
    }

    return BackButtonListener(
      onBackButtonPressed: () async {
        final backedAt = _backedAt;
        final now = DateTime.now();
        _backedAt = now;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('再次返回退出应用').center(),
            behavior: SnackBarBehavior.floating,
            elevation: 2,
            width: 200,
            duration: const Duration(milliseconds: 750),
          ),
        );

        if (backedAt == null) return true;
        if (now.difference(backedAt).inMilliseconds > 1000) return true;

        return false;
      },
      child: Scaffold(
        body: IndexedStack(
          index: tabIndex,
          children: const [
            ChatView(),
            ContactView(),
            ProfileView(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: tabIndex,
          onDestinationSelected: (v) {
            setState(() {
              tabIndex = v;
            });
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
