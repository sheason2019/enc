import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/rtc/rtc.model/session.dart';

class RtcMember {
  final AccountSnapshot snapshot;
  final String clientId;
  final RtcSession? session;

  void dispose() {
    session?.dispose();
  }

  RtcMember({
    required this.snapshot,
    required this.clientId,
    required this.session,
  });
}
