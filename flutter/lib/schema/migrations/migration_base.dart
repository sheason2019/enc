import 'package:drift/drift.dart';
import 'package:sheason_chat/schema/database.dart';

abstract class MigrationBase {
  Future<void> apply(AppDatabase db, Migrator m);
  Future<void> revert(AppDatabase db, Migrator m);
}
