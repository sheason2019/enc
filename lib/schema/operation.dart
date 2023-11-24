import 'package:isar/isar.dart';

part 'operation.g.dart';

@collection
class Operation {
  final int id;

  final String clientId;
  final int clock;

  String source;
  String apply;
  String revert;

  Operation({
    required this.id,
    required this.clock,
    required this.clientId,
    required this.source,
    required this.apply,
    required this.revert,
  });
}
