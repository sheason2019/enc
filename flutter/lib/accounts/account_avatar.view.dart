import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:styled_widget/styled_widget.dart';

class AccountAvatar extends StatelessWidget {
  final double size;
  final AccountSnapshot snapshot;
  const AccountAvatar({
    super.key,
    required this.snapshot,
    this.size = 40,
  });

  String get randomKey {
    if (snapshot.index.signPubKey.isEmpty) {
      return '0';
    } else {
      return snapshot.index.signPubKey;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (snapshot.avatarUrl.isNotEmpty) {
      return ExtendedImage.network(
        snapshot.avatarUrl,
        loadStateChanged: (state) {
          if (state.extendedImageLoadState == LoadState.failed) {
            return RandomAvatar(
              randomKey,
              width: size,
              height: size,
            );
          }

          return null;
        },
        enableLoadState: true,
        width: size,
        height: size,
      ).clipRRect(all: size);
    }

    return RandomAvatar(
      randomKey,
      width: size,
      height: size,
    );
  }
}
