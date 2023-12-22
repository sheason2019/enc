import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/scope/operator/operate_atom/operate_atom.dart';

class Operations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get clientId => text()();
  IntColumn get clock => integer()();
  BlobColumn get info => blob().map(PortableOperationTypeConverter())();
  TextColumn get atoms => text().map(OperateAtomTypeConverter()).nullable()();
}

class PortableOperationTypeConverter
    extends TypeConverter<PortableOperation, Uint8List> {
  @override
  PortableOperation fromSql(Uint8List fromDb) {
    return PortableOperation.fromBuffer(fromDb);
  }

  @override
  Uint8List toSql(PortableOperation value) {
    return value.writeToBuffer();
  }
}

class OperateAtomTypeConverter
    extends TypeConverter<List<OperateAtom>, String> {
  @override
  List<OperateAtom> fromSql(String fromDb) {
    final List list = jsonDecode(fromDb);
    return list.map((e) => OperateAtom.fromJson(jsonDecode(e))).toList();
  }

  @override
  String toSql(List<OperateAtom> value) {
    final list = value.map((e) => e.toJson()).map((e) => jsonEncode(e));
    return jsonEncode(list.toList());
  }
}
