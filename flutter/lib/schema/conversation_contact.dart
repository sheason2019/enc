import 'package:drift/drift.dart';
import 'package:ENC/schema/contact.dart';
import 'package:ENC/schema/conversation.dart';

class ConversationContacts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get conversationId => integer().references(Conversations, #id)();
  IntColumn get contactId => integer().references(Contacts, #id)();
}
