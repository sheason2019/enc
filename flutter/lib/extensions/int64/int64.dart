import 'package:fixnum/fixnum.dart';

extension Int64Extension on Int64 {
  DateTime? toDatetime() {
    final stamp = toInt();
    if (stamp == 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(stamp);
  }
}
