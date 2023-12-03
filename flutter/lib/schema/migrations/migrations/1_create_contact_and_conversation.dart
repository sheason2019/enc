// ignore_for_file: file_names

import 'package:drift/drift.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/schema/migrations/migration_base.dart';

class CreateContactAndConversationMigration extends MigrationBase {
  @override
  Future<void> apply(AppDatabase db, Migrator m) async {
    await m.createTable(db.contacts);
    await m.createTable(db.conversations);
    await m.createTable(db.conversationContacts);
  }

  @override
  Future<void> revert(AppDatabase db, Migrator m) async {
    await m.drop(db.conversationContacts);
    await m.drop(db.contacts);
    await m.drop(db.conversations);
  }
}
