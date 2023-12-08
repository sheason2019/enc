import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';

class AccountAvatar extends StatelessWidget {
  final AccountSnapshot snapshot;
  const AccountAvatar({
    super.key,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    const size = 40.0;
    return RandomAvatar(
      snapshot.index.signPubKey,
      width: size,
      height: size,
    );
  }
}
