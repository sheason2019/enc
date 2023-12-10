import 'package:path/path.dart' as path;

class AccountPaths {
  final String root;
  const AccountPaths({required this.root});

  String get cache => path.join(root, 'cache');
  String get snapshot => path.join(root, '.snapshot');
  String get conversationAnchor => path.join(root, '.conversation-anchor');
  String get secret => path.join(root, '.secret');
}
