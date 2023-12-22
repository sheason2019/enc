import 'package:json_annotation/json_annotation.dart';
import 'package:ENC/scope/operator/operate_atom/operate_atom_type.dart';

part 'operate_atom.g.dart';

@JsonSerializable()
class OperateAtom {
  OperateAtomType type;
  String? from;
  String to;

  Map<String, dynamic>? extra;

  OperateAtom({
    required this.type,
    required this.from,
    required this.to,
    this.extra,
  });

  factory OperateAtom.fromJson(Map<String, dynamic> json) =>
      _$OperateAtomFromJson(json);
  Map<String, dynamic> toJson() => _$OperateAtomToJson(this);
}
