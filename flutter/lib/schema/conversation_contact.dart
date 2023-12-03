import 'package:drift/drift.dart';
import 'package:sheason_chat/schema/contact.dart';
import 'package:sheason_chat/schema/conversation.dart';

class ConversationContacts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get conversationId => integer().references(Conversations, #id)();
  IntColumn get contactId => integer().references(Contacts, #id)();
}
