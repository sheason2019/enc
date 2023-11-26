import 'package:flutter/material.dart';

import 'base_delegate.dart';

class BaseDelegateWrapper extends StatelessWidget {
  final Widget child;
  final BaseDelegate delegate;

  const BaseDelegateWrapper({
    super.key,
    required this.delegate,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: delegate,
      builder: (context, _) => Navigator(
        onPopPage: (route, result) {
          delegate.pages.removeLast();
          delegate.notify();
          return route.didPop(result);
        },
        pages: [
          MaterialPage(child: child),
          for (final page in delegate.pages)
            MaterialPage(
              key: ObjectKey(page),
              child: page,
            ),
        ],
      ),
    );
  }
}

class MultiBaseDelegateWrapper extends StatelessWidget {
  final Widget child;
  final List<BaseDelegate> delegates;

  const MultiBaseDelegateWrapper({
    super.key,
    required this.child,
    required this.delegates,
  });

  @override
  Widget build(BuildContext context) {
    var output = child;
    for (final delegate in delegates) {
      output = BaseDelegateWrapper(delegate: delegate, child: output);
    }

    return output;
  }
}
