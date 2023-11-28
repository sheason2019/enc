import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BaseDelegate extends RouterDelegate<Widget>
    with PopNavigatorRouterDelegateMixin<Widget>, ChangeNotifier {
  final pages = <Widget>[];

  BaseDelegate({Widget? initialPage}) {
    if (initialPage != null) pages.add(initialPage);
  }

  notify() => notifyListeners();

  @override
  Widget? get currentConfiguration => pages.last;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onPopPage: (route, result) {
        pages.removeLast();
        notifyListeners();
        return route.didPop(result);
      },
      pages: [
        for (final page in pages)
          MaterialPage(
            key: ValueKey(page.runtimeType),
            child: page,
          ),
      ],
    );
  }

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) async {
    pages.add(configuration);
    return SynchronousFuture(null);
  }
}
