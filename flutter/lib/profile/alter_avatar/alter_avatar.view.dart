import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ENC/accounts/account_avatar.view.dart';
import 'package:ENC/profile/alter_avatar/edit/edit.view.dart';
import 'package:ENC/profile/alter_avatar/preview/preview.view.dart';
import 'package:ENC/profile/alter_avatar/remove/remove.view.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class AlterAvatarWidget extends StatelessWidget {
  const AlterAvatarWidget({super.key});

  handleClickAvatar(BuildContext context) async {
    final option = await showModalBottomSheet<_AlterAvatarOption>(
      context: context,
      builder: (context) => const _MenuBottomSheet(),
    );
    if (option == null) return;

    if (context.mounted) {
      switch (option) {
        case _AlterAvatarOption.gallery:
          return handleGralley(context);
        case _AlterAvatarOption.remove:
          return handleRemove(context);
      }
    }
  }

  handleGralley(BuildContext context) async {
    final delegate = context.read<Scope>().router.profileDelegate;
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) return;

    delegate.pages.add(AlterAvatarEditPage(
      imageFile: imageFile,
      target: AvatarSubmitTarget.snapshot,
    ));
    delegate.notify();
  }

  handleRemove(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlterAvatarRemoveDialog(
        scope: context.read<Scope>(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => handleClickAvatar(context),
        child: AccountAvatar(
          snapshot: scope.snapshot,
          size: 96,
        ),
      ),
    );
  }
}

enum _AlterAvatarOption {
  gallery,
  remove,
}

class _MenuBottomSheet extends StatelessWidget {
  const _MenuBottomSheet();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Text(
          '修改用户头像',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ).padding(top: 16, bottom: 8),
        ListTile(
          onTap: () => Navigator.of(context).pop(_AlterAvatarOption.gallery),
          title: const Text('从相册选择图片'),
        ),
        ListTile(
          onTap: () => Navigator.of(context).pop(_AlterAvatarOption.remove),
          title: const Text('恢复至默认头像'),
        )
      ],
    );
  }
}
