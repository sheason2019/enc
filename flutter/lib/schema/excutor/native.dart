import 'dart:io';

import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:drift/drift.dart';

QueryExecutor createExcutor(String accountKey) {
  return LazyDatabase(() async {
    final file = File(path.join(accountKey, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
