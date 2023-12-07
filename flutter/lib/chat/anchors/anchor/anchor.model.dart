import 'package:flutter/foundation.dart';

@immutable
class ConversationAnchorContext {
  final String conversationName;
  final String? messagePreview;
  final DateTime? messageDatetime;
  final int uncheckCount;

  const ConversationAnchorContext({
    required this.conversationName,
    required this.messageDatetime,
    required this.messagePreview,
    required this.uncheckCount,
  });
}
