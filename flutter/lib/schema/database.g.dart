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
  static const VerificationMeta _infoMeta = const VerificationMeta('info');
  @override
  late final GeneratedColumnWithTypeConverter<PortableOperation, Uint8List>
      info = GeneratedColumn<Uint8List>('info', aliasedName, false,
              type: DriftSqlType.blob, requiredDuringInsert: true)
          .withConverter<PortableOperation>($OperationsTable.$converterinfo);
  static const VerificationMeta _atomsMeta = const VerificationMeta('atoms');
  @override
  late final GeneratedColumnWithTypeConverter<List<OperateAtom>?, String>
      atoms = GeneratedColumn<String>('atoms', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<OperateAtom>?>($OperationsTable.$converteratomsn);
  @override
  List<GeneratedColumn> get $columns => [id, clientId, clock, info, atoms];
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
    context.handle(_infoMeta, const VerificationResult.success());
    context.handle(_atomsMeta, const VerificationResult.success());
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
      info: $OperationsTable.$converterinfo.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}info'])!),
      atoms: $OperationsTable.$converteratomsn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}atoms'])),
    );
  }

  @override
  $OperationsTable createAlias(String alias) {
    return $OperationsTable(attachedDatabase, alias);
  }

  static TypeConverter<PortableOperation, Uint8List> $converterinfo =
      PortableOperationTypeConverter();
  static TypeConverter<List<OperateAtom>, String> $converteratoms =
      OperateAtomTypeConverter();
  static TypeConverter<List<OperateAtom>?, String?> $converteratomsn =
      NullAwareTypeConverter.wrap($converteratoms);
}

class Operation extends DataClass implements Insertable<Operation> {
  final int id;
  final String clientId;
  final int clock;
  final PortableOperation info;
  final List<OperateAtom>? atoms;
  const Operation(
      {required this.id,
      required this.clientId,
      required this.clock,
      required this.info,
      this.atoms});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_id'] = Variable<String>(clientId);
    map['clock'] = Variable<int>(clock);
    {
      final converter = $OperationsTable.$converterinfo;
      map['info'] = Variable<Uint8List>(converter.toSql(info));
    }
    if (!nullToAbsent || atoms != null) {
      final converter = $OperationsTable.$converteratomsn;
      map['atoms'] = Variable<String>(converter.toSql(atoms));
    }
    return map;
  }

  OperationsCompanion toCompanion(bool nullToAbsent) {
    return OperationsCompanion(
      id: Value(id),
      clientId: Value(clientId),
      clock: Value(clock),
      info: Value(info),
      atoms:
          atoms == null && nullToAbsent ? const Value.absent() : Value(atoms),
    );
  }

  factory Operation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Operation(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      clock: serializer.fromJson<int>(json['clock']),
      info: serializer.fromJson<PortableOperation>(json['info']),
      atoms: serializer.fromJson<List<OperateAtom>?>(json['atoms']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<String>(clientId),
      'clock': serializer.toJson<int>(clock),
      'info': serializer.toJson<PortableOperation>(info),
      'atoms': serializer.toJson<List<OperateAtom>?>(atoms),
    };
  }

  Operation copyWith(
          {int? id,
          String? clientId,
          int? clock,
          PortableOperation? info,
          Value<List<OperateAtom>?> atoms = const Value.absent()}) =>
      Operation(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        clock: clock ?? this.clock,
        info: info ?? this.info,
        atoms: atoms.present ? atoms.value : this.atoms,
      );
  @override
  String toString() {
    return (StringBuffer('Operation(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('clock: $clock, ')
          ..write('info: $info, ')
          ..write('atoms: $atoms')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, clientId, clock, info, atoms);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Operation &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.clock == this.clock &&
          other.info == this.info &&
          other.atoms == this.atoms);
}

class OperationsCompanion extends UpdateCompanion<Operation> {
  final Value<int> id;
  final Value<String> clientId;
  final Value<int> clock;
  final Value<PortableOperation> info;
  final Value<List<OperateAtom>?> atoms;
  const OperationsCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.clock = const Value.absent(),
    this.info = const Value.absent(),
    this.atoms = const Value.absent(),
  });
  OperationsCompanion.insert({
    this.id = const Value.absent(),
    required String clientId,
    required int clock,
    required PortableOperation info,
    this.atoms = const Value.absent(),
  })  : clientId = Value(clientId),
        clock = Value(clock),
        info = Value(info);
  static Insertable<Operation> custom({
    Expression<int>? id,
    Expression<String>? clientId,
    Expression<int>? clock,
    Expression<Uint8List>? info,
    Expression<String>? atoms,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (clock != null) 'clock': clock,
      if (info != null) 'info': info,
      if (atoms != null) 'atoms': atoms,
    });
  }

  OperationsCompanion copyWith(
      {Value<int>? id,
      Value<String>? clientId,
      Value<int>? clock,
      Value<PortableOperation>? info,
      Value<List<OperateAtom>?>? atoms}) {
    return OperationsCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      clock: clock ?? this.clock,
      info: info ?? this.info,
      atoms: atoms ?? this.atoms,
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
    if (info.present) {
      final converter = $OperationsTable.$converterinfo;

      map['info'] = Variable<Uint8List>(converter.toSql(info.value));
    }
    if (atoms.present) {
      final converter = $OperationsTable.$converteratomsn;

      map['atoms'] = Variable<String>(converter.toSql(atoms.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OperationsCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('clock: $clock, ')
          ..write('info: $info, ')
          ..write('atoms: $atoms')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts with TableInfo<$ContactsTable, Contact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _signPubkeyMeta =
      const VerificationMeta('signPubkey');
  @override
  late final GeneratedColumn<String> signPubkey = GeneratedColumn<String>(
      'sign_pubkey', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _snapshotMeta =
      const VerificationMeta('snapshot');
  @override
  late final GeneratedColumnWithTypeConverter<AccountSnapshot, Uint8List>
      snapshot = GeneratedColumn<Uint8List>('snapshot', aliasedName, false,
              type: DriftSqlType.blob, requiredDuringInsert: true)
          .withConverter<AccountSnapshot>($ContactsTable.$convertersnapshot);
  @override
  List<GeneratedColumn> get $columns => [id, signPubkey, snapshot];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(Insertable<Contact> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sign_pubkey')) {
      context.handle(
          _signPubkeyMeta,
          signPubkey.isAcceptableOrUnknown(
              data['sign_pubkey']!, _signPubkeyMeta));
    } else if (isInserting) {
      context.missing(_signPubkeyMeta);
    }
    context.handle(_snapshotMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contact(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      signPubkey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sign_pubkey'])!,
      snapshot: $ContactsTable.$convertersnapshot.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}snapshot'])!),
    );
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountSnapshot, Uint8List> $convertersnapshot =
      SnapshotConvert();
}

class Contact extends DataClass implements Insertable<Contact> {
  final int id;
  final String signPubkey;
  final AccountSnapshot snapshot;
  const Contact(
      {required this.id, required this.signPubkey, required this.snapshot});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sign_pubkey'] = Variable<String>(signPubkey);
    {
      final converter = $ContactsTable.$convertersnapshot;
      map['snapshot'] = Variable<Uint8List>(converter.toSql(snapshot));
    }
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      id: Value(id),
      signPubkey: Value(signPubkey),
      snapshot: Value(snapshot),
    );
  }

  factory Contact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contact(
      id: serializer.fromJson<int>(json['id']),
      signPubkey: serializer.fromJson<String>(json['signPubkey']),
      snapshot: serializer.fromJson<AccountSnapshot>(json['snapshot']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'signPubkey': serializer.toJson<String>(signPubkey),
      'snapshot': serializer.toJson<AccountSnapshot>(snapshot),
    };
  }

  Contact copyWith({int? id, String? signPubkey, AccountSnapshot? snapshot}) =>
      Contact(
        id: id ?? this.id,
        signPubkey: signPubkey ?? this.signPubkey,
        snapshot: snapshot ?? this.snapshot,
      );
  @override
  String toString() {
    return (StringBuffer('Contact(')
          ..write('id: $id, ')
          ..write('signPubkey: $signPubkey, ')
          ..write('snapshot: $snapshot')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, signPubkey, snapshot);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contact &&
          other.id == this.id &&
          other.signPubkey == this.signPubkey &&
          other.snapshot == this.snapshot);
}

class ContactsCompanion extends UpdateCompanion<Contact> {
  final Value<int> id;
  final Value<String> signPubkey;
  final Value<AccountSnapshot> snapshot;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.signPubkey = const Value.absent(),
    this.snapshot = const Value.absent(),
  });
  ContactsCompanion.insert({
    this.id = const Value.absent(),
    required String signPubkey,
    required AccountSnapshot snapshot,
  })  : signPubkey = Value(signPubkey),
        snapshot = Value(snapshot);
  static Insertable<Contact> custom({
    Expression<int>? id,
    Expression<String>? signPubkey,
    Expression<Uint8List>? snapshot,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (signPubkey != null) 'sign_pubkey': signPubkey,
      if (snapshot != null) 'snapshot': snapshot,
    });
  }

  ContactsCompanion copyWith(
      {Value<int>? id,
      Value<String>? signPubkey,
      Value<AccountSnapshot>? snapshot}) {
    return ContactsCompanion(
      id: id ?? this.id,
      signPubkey: signPubkey ?? this.signPubkey,
      snapshot: snapshot ?? this.snapshot,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (signPubkey.present) {
      map['sign_pubkey'] = Variable<String>(signPubkey.value);
    }
    if (snapshot.present) {
      final converter = $ContactsTable.$convertersnapshot;

      map['snapshot'] = Variable<Uint8List>(converter.toSql(snapshot.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('id: $id, ')
          ..write('signPubkey: $signPubkey, ')
          ..write('snapshot: $snapshot')
          ..write(')'))
        .toString();
  }
}

class $ConversationsTable extends Conversations
    with TableInfo<$ConversationsTable, Conversation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<ConversationType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<ConversationType>($ConversationsTable.$convertertype);
  static const VerificationMeta _ecdhPubkeyMeta =
      const VerificationMeta('ecdhPubkey');
  @override
  late final GeneratedColumn<String> ecdhPubkey = GeneratedColumn<String>(
      'ecdh_pubkey', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _signPubkeyMeta =
      const VerificationMeta('signPubkey');
  @override
  late final GeneratedColumn<String> signPubkey = GeneratedColumn<String>(
      'sign_pubkey', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _infoMeta = const VerificationMeta('info');
  @override
  late final GeneratedColumnWithTypeConverter<PortableConversation, Uint8List>
      info = GeneratedColumn<Uint8List>('info', aliasedName, false,
              type: DriftSqlType.blob, requiredDuringInsert: true)
          .withConverter<PortableConversation>(
              $ConversationsTable.$converterinfo);
  @override
  List<GeneratedColumn> get $columns =>
      [id, type, ecdhPubkey, signPubkey, info];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conversations';
  @override
  VerificationContext validateIntegrity(Insertable<Conversation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('ecdh_pubkey')) {
      context.handle(
          _ecdhPubkeyMeta,
          ecdhPubkey.isAcceptableOrUnknown(
              data['ecdh_pubkey']!, _ecdhPubkeyMeta));
    } else if (isInserting) {
      context.missing(_ecdhPubkeyMeta);
    }
    if (data.containsKey('sign_pubkey')) {
      context.handle(
          _signPubkeyMeta,
          signPubkey.isAcceptableOrUnknown(
              data['sign_pubkey']!, _signPubkeyMeta));
    } else if (isInserting) {
      context.missing(_signPubkeyMeta);
    }
    context.handle(_infoMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Conversation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Conversation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      type: $ConversationsTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      ecdhPubkey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ecdh_pubkey'])!,
      signPubkey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sign_pubkey'])!,
      info: $ConversationsTable.$converterinfo.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}info'])!),
    );
  }

  @override
  $ConversationsTable createAlias(String alias) {
    return $ConversationsTable(attachedDatabase, alias);
  }

  static TypeConverter<ConversationType, int> $convertertype =
      ConversationTypeConverter();
  static TypeConverter<PortableConversation, Uint8List> $converterinfo =
      ConversationInfoTypeConverter();
}

class Conversation extends DataClass implements Insertable<Conversation> {
  final int id;
  final ConversationType type;
  final String ecdhPubkey;
  final String signPubkey;
  final PortableConversation info;
  const Conversation(
      {required this.id,
      required this.type,
      required this.ecdhPubkey,
      required this.signPubkey,
      required this.info});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      final converter = $ConversationsTable.$convertertype;
      map['type'] = Variable<int>(converter.toSql(type));
    }
    map['ecdh_pubkey'] = Variable<String>(ecdhPubkey);
    map['sign_pubkey'] = Variable<String>(signPubkey);
    {
      final converter = $ConversationsTable.$converterinfo;
      map['info'] = Variable<Uint8List>(converter.toSql(info));
    }
    return map;
  }

  ConversationsCompanion toCompanion(bool nullToAbsent) {
    return ConversationsCompanion(
      id: Value(id),
      type: Value(type),
      ecdhPubkey: Value(ecdhPubkey),
      signPubkey: Value(signPubkey),
      info: Value(info),
    );
  }

  factory Conversation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Conversation(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<ConversationType>(json['type']),
      ecdhPubkey: serializer.fromJson<String>(json['ecdhPubkey']),
      signPubkey: serializer.fromJson<String>(json['signPubkey']),
      info: serializer.fromJson<PortableConversation>(json['info']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<ConversationType>(type),
      'ecdhPubkey': serializer.toJson<String>(ecdhPubkey),
      'signPubkey': serializer.toJson<String>(signPubkey),
      'info': serializer.toJson<PortableConversation>(info),
    };
  }

  Conversation copyWith(
          {int? id,
          ConversationType? type,
          String? ecdhPubkey,
          String? signPubkey,
          PortableConversation? info}) =>
      Conversation(
        id: id ?? this.id,
        type: type ?? this.type,
        ecdhPubkey: ecdhPubkey ?? this.ecdhPubkey,
        signPubkey: signPubkey ?? this.signPubkey,
        info: info ?? this.info,
      );
  @override
  String toString() {
    return (StringBuffer('Conversation(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('ecdhPubkey: $ecdhPubkey, ')
          ..write('signPubkey: $signPubkey, ')
          ..write('info: $info')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, ecdhPubkey, signPubkey, info);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Conversation &&
          other.id == this.id &&
          other.type == this.type &&
          other.ecdhPubkey == this.ecdhPubkey &&
          other.signPubkey == this.signPubkey &&
          other.info == this.info);
}

class ConversationsCompanion extends UpdateCompanion<Conversation> {
  final Value<int> id;
  final Value<ConversationType> type;
  final Value<String> ecdhPubkey;
  final Value<String> signPubkey;
  final Value<PortableConversation> info;
  const ConversationsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.ecdhPubkey = const Value.absent(),
    this.signPubkey = const Value.absent(),
    this.info = const Value.absent(),
  });
  ConversationsCompanion.insert({
    this.id = const Value.absent(),
    required ConversationType type,
    required String ecdhPubkey,
    required String signPubkey,
    required PortableConversation info,
  })  : type = Value(type),
        ecdhPubkey = Value(ecdhPubkey),
        signPubkey = Value(signPubkey),
        info = Value(info);
  static Insertable<Conversation> custom({
    Expression<int>? id,
    Expression<int>? type,
    Expression<String>? ecdhPubkey,
    Expression<String>? signPubkey,
    Expression<Uint8List>? info,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (ecdhPubkey != null) 'ecdh_pubkey': ecdhPubkey,
      if (signPubkey != null) 'sign_pubkey': signPubkey,
      if (info != null) 'info': info,
    });
  }

  ConversationsCompanion copyWith(
      {Value<int>? id,
      Value<ConversationType>? type,
      Value<String>? ecdhPubkey,
      Value<String>? signPubkey,
      Value<PortableConversation>? info}) {
    return ConversationsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      ecdhPubkey: ecdhPubkey ?? this.ecdhPubkey,
      signPubkey: signPubkey ?? this.signPubkey,
      info: info ?? this.info,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      final converter = $ConversationsTable.$convertertype;

      map['type'] = Variable<int>(converter.toSql(type.value));
    }
    if (ecdhPubkey.present) {
      map['ecdh_pubkey'] = Variable<String>(ecdhPubkey.value);
    }
    if (signPubkey.present) {
      map['sign_pubkey'] = Variable<String>(signPubkey.value);
    }
    if (info.present) {
      final converter = $ConversationsTable.$converterinfo;

      map['info'] = Variable<Uint8List>(converter.toSql(info.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConversationsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('ecdhPubkey: $ecdhPubkey, ')
          ..write('signPubkey: $signPubkey, ')
          ..write('info: $info')
          ..write(')'))
        .toString();
  }
}

class $ConversationContactsTable extends ConversationContacts
    with TableInfo<$ConversationContactsTable, ConversationContact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversationContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _conversationIdMeta =
      const VerificationMeta('conversationId');
  @override
  late final GeneratedColumn<int> conversationId = GeneratedColumn<int>(
      'conversation_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES conversations (id)'));
  static const VerificationMeta _contactIdMeta =
      const VerificationMeta('contactId');
  @override
  late final GeneratedColumn<int> contactId = GeneratedColumn<int>(
      'contact_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES contacts (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, conversationId, contactId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conversation_contacts';
  @override
  VerificationContext validateIntegrity(
      Insertable<ConversationContact> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
          _conversationIdMeta,
          conversationId.isAcceptableOrUnknown(
              data['conversation_id']!, _conversationIdMeta));
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('contact_id')) {
      context.handle(_contactIdMeta,
          contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta));
    } else if (isInserting) {
      context.missing(_contactIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConversationContact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConversationContact(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      conversationId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}conversation_id'])!,
      contactId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}contact_id'])!,
    );
  }

  @override
  $ConversationContactsTable createAlias(String alias) {
    return $ConversationContactsTable(attachedDatabase, alias);
  }
}

class ConversationContact extends DataClass
    implements Insertable<ConversationContact> {
  final int id;
  final int conversationId;
  final int contactId;
  const ConversationContact(
      {required this.id,
      required this.conversationId,
      required this.contactId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['conversation_id'] = Variable<int>(conversationId);
    map['contact_id'] = Variable<int>(contactId);
    return map;
  }

  ConversationContactsCompanion toCompanion(bool nullToAbsent) {
    return ConversationContactsCompanion(
      id: Value(id),
      conversationId: Value(conversationId),
      contactId: Value(contactId),
    );
  }

  factory ConversationContact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConversationContact(
      id: serializer.fromJson<int>(json['id']),
      conversationId: serializer.fromJson<int>(json['conversationId']),
      contactId: serializer.fromJson<int>(json['contactId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'conversationId': serializer.toJson<int>(conversationId),
      'contactId': serializer.toJson<int>(contactId),
    };
  }

  ConversationContact copyWith(
          {int? id, int? conversationId, int? contactId}) =>
      ConversationContact(
        id: id ?? this.id,
        conversationId: conversationId ?? this.conversationId,
        contactId: contactId ?? this.contactId,
      );
  @override
  String toString() {
    return (StringBuffer('ConversationContact(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('contactId: $contactId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, conversationId, contactId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConversationContact &&
          other.id == this.id &&
          other.conversationId == this.conversationId &&
          other.contactId == this.contactId);
}

class ConversationContactsCompanion
    extends UpdateCompanion<ConversationContact> {
  final Value<int> id;
  final Value<int> conversationId;
  final Value<int> contactId;
  const ConversationContactsCompanion({
    this.id = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.contactId = const Value.absent(),
  });
  ConversationContactsCompanion.insert({
    this.id = const Value.absent(),
    required int conversationId,
    required int contactId,
  })  : conversationId = Value(conversationId),
        contactId = Value(contactId);
  static Insertable<ConversationContact> custom({
    Expression<int>? id,
    Expression<int>? conversationId,
    Expression<int>? contactId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (conversationId != null) 'conversation_id': conversationId,
      if (contactId != null) 'contact_id': contactId,
    });
  }

  ConversationContactsCompanion copyWith(
      {Value<int>? id, Value<int>? conversationId, Value<int>? contactId}) {
    return ConversationContactsCompanion(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      contactId: contactId ?? this.contactId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<int>(conversationId.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<int>(contactId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConversationContactsCompanion(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('contactId: $contactId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $OperationsTable operations = $OperationsTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $ConversationsTable conversations = $ConversationsTable(this);
  late final $ConversationContactsTable conversationContacts =
      $ConversationContactsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [operations, contacts, conversations, conversationContacts];
}
