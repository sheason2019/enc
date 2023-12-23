import 'package:ENC/scope/layout/layout.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/contacts/contacts.view.dart';
import 'package:ENC/main.controller.dart';
import 'package:ENC/scope/scope.collection.dart';
import 'package:ENC/chat/chat.view.dart';
import 'package:ENC/profile/profile.view.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class ScopePage extends StatefulWidget {
  final Scope scope;
  const ScopePage({super.key, required this.scope});

  @override
  State<StatefulWidget> createState() => _ScopePageState();
}

class _ScopePageState extends State<ScopePage> {
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
        final delegate = context.read<MainController>().rootDelegate;
        if (delegate.pages.length > 1) return false;

        final router = context.read<Scope>().router;
        switch (router.tabIndex) {
          case 0:
            if (router.chatDelegate.pages.isNotEmpty) {
              router.chatDelegate.pages.removeLast();
              router.chatDelegate.notify();
              return true;
            }
            break;
          case 1:
            if (router.contactDelegate.pages.isNotEmpty) {
              router.contactDelegate.pages.removeLast();
              router.contactDelegate.notify();
              return true;
            }
            break;
          case 2:
            if (router.profileDelegate.pages.isNotEmpty) {
              router.profileDelegate.pages.removeLast();
              router.profileDelegate.notify();
              return true;
            }
            break;
        }

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
      child: ListenableBuilder(
        listenable: scope.router,
        builder: (context, _) => ScopeLayout(
          child: IndexedStack(
            index: scope.router.tabIndex,
            children: const [
              ChatView(),
              ContactView(),
              ProfileView(),
            ],
          ),
        ),
      ),
    );
  }
}
