// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $OperationsTable extends Operations
    with TableInfo<$OperationsTable, Operation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OperationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _clientIdMeta =
      const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
      'client_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _clockMeta = const VerificationMeta('clock');
  @override
  late final GeneratedColumn<int> clock = GeneratedColumn<int>(
      'clock', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _applyMeta = const VerificationMeta('apply');
  @override
  late final GeneratedColumn<String> apply = GeneratedColumn<String>(
      'apply', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, clientId, clock, payload, apply];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'operations';
  @override
  VerificationContext validateIntegrity(Insertable<Operation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('clock')) {
      context.handle(
          _clockMeta, clock.isAcceptableOrUnknown(data['clock']!, _clockMeta));
    } else if (isInserting) {
      context.missing(_clockMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('apply')) {
      context.handle(
          _applyMeta, apply.isAcceptableOrUnknown(data['apply']!, _applyMeta));
    } else if (isInserting) {
      context.missing(_applyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Operation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Operation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      clientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_id'])!,
      clock: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}clock'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      apply: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}apply'])!,
    );
  }

  @override
  $OperationsTable createAlias(String alias) {
    return $OperationsTable(attachedDatabase, alias);
  }
}

class Operation extends DataClass implements Insertable<Operation> {
  final int id;
  final String clientId;
  final int clock;
  final String payload;
  final String apply;
  const Operation(
      {required this.id,
      required this.clientId,
      required this.clock,
      required this.payload,
      required this.apply});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_id'] = Variable<String>(clientId);
    map['clock'] = Variable<int>(clock);
    map['payload'] = Variable<String>(payload);
    map['apply'] = Variable<String>(apply);
    return map;
  }

  OperationsCompanion toCompanion(bool nullToAbsent) {
    return OperationsCompanion(
      id: Value(id),
      clientId: Value(clientId),
      clock: Value(clock),
      payload: Value(payload),
      apply: Value(apply),
    );
  }

  factory Operation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Operation(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      clock: serializer.fromJson<int>(json['clock']),
      payload: serializer.fromJson<String>(json['payload']),
      apply: serializer.fromJson<String>(json['apply']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<String>(clientId),
      'clock': serializer.toJson<int>(clock),
      'payload': serializer.toJson<String>(payload),
      'apply': serializer.toJson<String>(apply),
    };
  }

  Operation copyWith(
          {int? id,
          String? clientId,
          int? clock,
          String? payload,
          String? apply}) =>
      Operation(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        clock: clock ?? this.clock,
        payload: payload ?? this.payload,
        apply: apply ?? this.apply,
      );
  @override
  String toString() {
    return (StringBuffer('Operation(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('clock: $clock, ')
          ..write('payload: $payload, ')
          ..write('apply: $apply')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, clientId, clock, payload, apply);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Operation &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.clock == this.clock &&
          other.payload == this.payload &&
          other.apply == this.apply);
}

class OperationsCompanion extends UpdateCompanion<Operation> {
  final Value<int> id;
  final Value<String> clientId;
  final Value<int> clock;
  final Value<String> payload;
  final Value<String> apply;
  const OperationsCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.clock = const Value.absent(),
    this.payload = const Value.absent(),
    this.apply = const Value.absent(),
  });
  OperationsCompanion.insert({
    this.id = const Value.absent(),
    required String clientId,
    required int clock,
    required String payload,
    required String apply,
  })  : clientId = Value(clientId),
        clock = Value(clock),
        payload = Value(payload),
        apply = Value(apply);
  static Insertable<Operation> custom({
    Expression<int>? id,
    Expression<String>? clientId,
    Expression<int>? clock,
    Expression<String>? payload,
    Expression<String>? apply,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (clock != null) 'clock': clock,
      if (payload != null) 'payload': payload,
      if (apply != null) 'apply': apply,
    });
  }

  OperationsCompanion copyWith(
      {Value<int>? id,
      Value<String>? clientId,
      Value<int>? clock,
      Value<String>? payload,
      Value<String>? apply}) {
    return OperationsCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      clock: clock ?? this.clock,
      payload: payload ?? this.payload,
      apply: apply ?? this.apply,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (clock.present) {
      map['clock'] = Variable<int>(clock.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (apply.present) {
      map['apply'] = Variable<String>(apply.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OperationsCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('clock: $clock, ')
          ..write('payload: $payload, ')
          ..write('apply: $apply')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $OperationsTable operations = $OperationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [operations];
}
