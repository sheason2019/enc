import 'package:drift/drift.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/schema/migrations/migration_base.dart';

class MigrationDelegate {
  MigrationDelegate._();

  static final migrations = <MigrationBase>[];

  static int use(MigrationBase? mig) {
    if (mig == null) return 1;
    final index =
        migrations.map((e) => e.runtimeType).toList().indexOf(mig.runtimeType);

    if (index < 0) {
      throw Exception('migration index must be positive');
    }

    return index + 2;
  }

  static Future<void> upgrade(
    AppDatabase db,
    Migrator m,
    int from,
    int to,
  ) async {
    var isDowngrade = from > to;
    if (isDowngrade) {
      for (var i = from; i >= to; i--) {
        final migrationIndex = i - 2;
        if (migrationIndex < 0) continue;

        final migration = migrations[migrationIndex];
        await migration.revert(db, m);
      }
    } else {
      for (var i = from; i <= to; i++) {
        final migrationIndex = i - 2;
        if (migrationIndex < 0) continue;

        final migration = migrations[migrationIndex];
        await migration.apply(db, m);
      }
    }
  }
}
