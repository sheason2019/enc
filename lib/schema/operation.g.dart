// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOperationCollection on Isar {
  IsarCollection<Operation> get operations => this.collection();
}

const OperationSchema = CollectionSchema(
  name: r'Operation',
  id: -4996007378082647893,
  properties: {
    r'apply': PropertySchema(
      id: 0,
      name: r'apply',
      type: IsarType.string,
    ),
    r'clientId': PropertySchema(
      id: 1,
      name: r'clientId',
      type: IsarType.string,
    ),
    r'clock': PropertySchema(
      id: 2,
      name: r'clock',
      type: IsarType.long,
    ),
    r'payload': PropertySchema(
      id: 3,
      name: r'payload',
      type: IsarType.string,
    )
  },
  estimateSize: _operationEstimateSize,
  serialize: _operationSerialize,
  deserialize: _operationDeserialize,
  deserializeProp: _operationDeserializeProp,
  idName: r'id',
  indexes: {
    r'clientId': IndexSchema(
      id: 2639372232964765565,
      name: r'clientId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'clientId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'clock': IndexSchema(
      id: 744193032584927484,
      name: r'clock',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'clock',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _operationGetId,
  getLinks: _operationGetLinks,
  attach: _operationAttach,
  version: '3.1.0+1',
);

int _operationEstimateSize(
  Operation object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.apply.length * 3;
  bytesCount += 3 + object.clientId.length * 3;
  bytesCount += 3 + object.payload.length * 3;
  return bytesCount;
}

void _operationSerialize(
  Operation object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.apply);
  writer.writeString(offsets[1], object.clientId);
  writer.writeLong(offsets[2], object.clock);
  writer.writeString(offsets[3], object.payload);
}

Operation _operationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Operation(
    apply: reader.readString(offsets[0]),
    clientId: reader.readString(offsets[1]),
    clock: reader.readLong(offsets[2]),
    payload: reader.readString(offsets[3]),
  );
  object.id = id;
  return object;
}

P _operationDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _operationGetId(Operation object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _operationGetLinks(Operation object) {
  return [];
}

void _operationAttach(IsarCollection<dynamic> col, Id id, Operation object) {
  object.id = id;
}

extension OperationQueryWhereSort
    on QueryBuilder<Operation, Operation, QWhere> {
  QueryBuilder<Operation, Operation, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Operation, Operation, QAfterWhere> anyClock() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'clock'),
      );
    });
  }
}

extension OperationQueryWhere
    on QueryBuilder<Operation, Operation, QWhereClause> {
  QueryBuilder<Operation, Operation, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Operation, Operation, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Operation, Operation, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Operation, Operation, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterWhereClause> clientIdEqualTo(
      String clientId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'clientId',
        value: [clientId],
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterWhereClause> clientIdNotEqualTo(
      String clientId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clientId',
              lower: [],
              upper: [clientId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clientId',
              lower: [clientId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clientId',
              lower: [clientId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clientId',
              lower: [],
              upper: [clientId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Operation, Operation, QAfterWhereClause> clockEqualTo(
      int clock) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'clock',
        value: [clock],
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterWhereClause> clockNotEqualTo(
      int clock) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clock',
              lower: [],
              upper: [clock],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clock',
              lower: [clock],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clock',
              lower: [clock],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clock',
              lower: [],
              upper: [clock],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Operation, Operation, QAfterWhereClause> clockGreaterThan(
    int clock, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'clock',
        lower: [clock],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterWhereClause> clockLessThan(
    int clock, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'clock',
        lower: [],
        upper: [clock],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterWhereClause> clockBetween(
    int lowerClock,
    int upperClock, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'clock',
        lower: [lowerClock],
        includeLower: includeLower,
        upper: [upperClock],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension OperationQueryFilter
    on QueryBuilder<Operation, Operation, QFilterCondition> {
  QueryBuilder<Operation, Operation, QAfterFilterCondition> applyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apply',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> applyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'apply',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> applyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'apply',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> applyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'apply',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> applyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'apply',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> applyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'apply',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> applyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'apply',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> applyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'apply',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> applyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apply',
        value: '',
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> applyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'apply',
        value: '',
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> clientIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> clientIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> clientIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> clientIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clientId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> clientIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> clientIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> clientIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> clientIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clientId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> clientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientId',
        value: '',
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition>
      clientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clientId',
        value: '',
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> clockEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clock',
        value: value,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> clockGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clock',
        value: value,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> clockLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clock',
        value: value,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> clockBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clock',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> payloadEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> payloadGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'payload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> payloadLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'payload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> payloadBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'payload',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> payloadStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'payload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> payloadEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'payload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> payloadContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'payload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> payloadMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'payload',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> payloadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payload',
        value: '',
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition>
      payloadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'payload',
        value: '',
      ));
    });
  }
}

extension OperationQueryObject
    on QueryBuilder<Operation, Operation, QFilterCondition> {}

extension OperationQueryLinks
    on QueryBuilder<Operation, Operation, QFilterCondition> {}

extension OperationQuerySortBy on QueryBuilder<Operation, Operation, QSortBy> {
  QueryBuilder<Operation, Operation, QAfterSortBy> sortByApply() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apply', Sort.asc);
    });
  }

  QueryBuilder<Operation, Operation, QAfterSortBy> sortByApplyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apply', Sort.desc);
    });
  }

  QueryBuilder<Operation, Operation, QAfterSortBy> sortByClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.asc);
    });
  }

  QueryBuilder<Operation, Operation, QAfterSortBy> sortByClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.desc);
    });
  }

  QueryBuilder<Operation, Operation, QAfterSortBy> sortByClock() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clock', Sort.asc);
    });
  }

  QueryBuilder<Operation, Operation, QAfterSortBy> sortByClockDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clock', Sort.desc);
    });
  }

  QueryBuilder<Operation, Operation, QAfterSortBy> sortByPayload() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payload', Sort.asc);
    });
  }

  QueryBuilder<Operation, Operation, QAfterSortBy> sortByPayloadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payload', Sort.desc);
    });
  }
}

extension OperationQuerySortThenBy
    on QueryBuilder<Operation, Operation, QSortThenBy> {
  QueryBuilder<Operation, Operation, QAfterSortBy> thenByApply() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apply', Sort.asc);
    });
  }

  QueryBuilder<Operation, Operation, QAfterSortBy> thenByApplyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apply', Sort.desc);
    });
  }

  QueryBuilder<Operation, Operation, QAfterSortBy> thenByClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.asc);
    });
  }

  QueryBuilder<Operation, Operation, QAfterSortBy> thenByClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.desc);
    });
  }

  QueryBuilder<Operation, Operation, QAfterSortBy> thenByClock() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clock', Sort.asc);
    });
  }

  QueryBuilder<Operation, Operation, QAfterSortBy> thenByClockDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clock', Sort.desc);
    });
  }

  QueryBuilder<Operation, Operation, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Operation, Operation, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Operation, Operation, QAfterSortBy> thenByPayload() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payload', Sort.asc);
    });
  }

  QueryBuilder<Operation, Operation, QAfterSortBy> thenByPayloadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payload', Sort.desc);
    });
  }
}

extension OperationQueryWhereDistinct
    on QueryBuilder<Operation, Operation, QDistinct> {
  QueryBuilder<Operation, Operation, QDistinct> distinctByApply(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'apply', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Operation, Operation, QDistinct> distinctByClientId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Operation, Operation, QDistinct> distinctByClock() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clock');
    });
  }

  QueryBuilder<Operation, Operation, QDistinct> distinctByPayload(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'payload', caseSensitive: caseSensitive);
    });
  }
}

extension OperationQueryProperty
    on QueryBuilder<Operation, Operation, QQueryProperty> {
  QueryBuilder<Operation, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Operation, String, QQueryOperations> applyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'apply');
    });
  }

  QueryBuilder<Operation, String, QQueryOperations> clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientId');
    });
  }

  QueryBuilder<Operation, int, QQueryOperations> clockProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clock');
    });
  }

  QueryBuilder<Operation, String, QQueryOperations> payloadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'payload');
    });
  }
}
