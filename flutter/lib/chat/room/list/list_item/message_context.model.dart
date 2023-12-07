import 'package:flutter/foundation.dart';
import 'package:sheason_chat/schema/database.dart';

@immutable
class MessageContext {
  final Message message;
  final Contact contact;

  const MessageContext({
    required this.contact,
    required this.message,
  });
}
