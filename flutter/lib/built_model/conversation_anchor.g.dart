// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_anchor.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ConversationAnchor> _$conversationAnchorSerializer =
    new _$ConversationAnchorSerializer();

class _$ConversationAnchorSerializer
    implements StructuredSerializer<ConversationAnchor> {
  @override
  final Iterable<Type> types = const [ConversationAnchor, _$ConversationAnchor];
  @override
  final String wireName = 'ConversationAnchor';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ConversationAnchor object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(int)])),
    ];

    return result;
  }

  @override
  ConversationAnchor deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ConversationAnchorBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'list':
          result.list.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$ConversationAnchor extends ConversationAnchor {
  @override
  final BuiltList<int> list;

  factory _$ConversationAnchor(
          [void Function(ConversationAnchorBuilder)? updates]) =>
      (new ConversationAnchorBuilder()..update(updates))._build();

  _$ConversationAnchor._({required this.list}) : super._() {
    BuiltValueNullFieldError.checkNotNull(list, r'ConversationAnchor', 'list');
  }

  @override
  ConversationAnchor rebuild(
          void Function(ConversationAnchorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConversationAnchorBuilder toBuilder() =>
      new ConversationAnchorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConversationAnchor && list == other.list;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, list.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConversationAnchor')
          ..add('list', list))
        .toString();
  }
}

class ConversationAnchorBuilder
    implements Builder<ConversationAnchor, ConversationAnchorBuilder> {
  _$ConversationAnchor? _$v;

  ListBuilder<int>? _list;
  ListBuilder<int> get list => _$this._list ??= new ListBuilder<int>();
  set list(ListBuilder<int>? list) => _$this._list = list;

  ConversationAnchorBuilder();

  ConversationAnchorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _list = $v.list.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConversationAnchor other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ConversationAnchor;
  }

  @override
  void update(void Function(ConversationAnchorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConversationAnchor build() => _build();

  _$ConversationAnchor _build() {
    _$ConversationAnchor _$result;
    try {
      _$result = _$v ?? new _$ConversationAnchor._(list: list.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ConversationAnchor', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
