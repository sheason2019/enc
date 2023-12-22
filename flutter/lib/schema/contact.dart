import 'package:drift/drift.dart';
import 'package:ENC/prototypes/core.pb.dart';

class Contacts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get signPubkey => text()();
  BlobColumn get snapshot => blob().map(SnapshotConvert())();
}

class SnapshotConvert extends TypeConverter<AccountSnapshot, Uint8List> {
  @override
  AccountSnapshot fromSql(Uint8List fromDb) {
    return AccountSnapshot.fromBuffer(fromDb);
  }

  @override
  Uint8List toSql(AccountSnapshot value) {
    return value.writeToBuffer();
  }
}
