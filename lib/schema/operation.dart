import 'package:isar/isar.dart';

part 'operation.g.dart';

@collection
class Operation {
  Id id = Isar.autoIncrement;

  @Index()
  final String clientId;
  @Index()
  final int clock;

  String payload;
  String apply;

  Operation({
    required this.clock,
    required this.clientId,
    required this.payload,
    required this.apply,
  });
}
