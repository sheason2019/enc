import 'package:sheason_chat/accounts/accounts.view.dart';
import 'package:sheason_chat/home/home.view.dart';
import 'package:sheason_chat/router/base_delegate.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:sheason_chat/scope/scope.view.dart';

class MainController {
  final void Function(Scope? scope) onActiveScopeChanged;

  MainController({required this.onActiveScopeChanged});

  final rootDelegate = BaseDelegate(
    initialPage: const HomePage(),
  );

  handleEnterScope(Scope? scope) {
    rootDelegate.pages.clear();
    if (scope == null) {
      rootDelegate.pages.add(const AccountsPage());
    } else {
      rootDelegate.pages.add(ScopePage(scope: scope));
    }
    onActiveScopeChanged(scope);
    rootDelegate.notify();
  }

  dispose() {
    rootDelegate.dispose();
  }
}
