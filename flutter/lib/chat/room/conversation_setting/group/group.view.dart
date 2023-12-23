import 'package:ENC/scope/scope.model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ENC/chat/anchors/anchor/anchor.view.dart';
import 'package:ENC/chat/room/conversation_setting/group/alter_name.view.dart';
import 'package:ENC/profile/alter_avatar/edit/edit.view.dart';
import 'package:ENC/profile/alter_avatar/preview/preview.view.dart';
import 'package:ENC/schema/database.dart';
import 'package:styled_widget/styled_widget.dart';

class GroupSettings extends StatelessWidget {
  final Conversation conversation;
  const GroupSettings({super.key, required this.conversation});

  toAlterAvatar(BuildContext context) async {
    final delegate = context.read<Scope>().router.chatDelegate;
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) return;

    delegate.pages.add(AlterAvatarEditPage(
      imageFile: imageFile,
      target: AvatarSubmitTarget.conversation,
      conversation: conversation,
    ));
    delegate.notify();
  }

  toAlterGroupName(BuildContext context) {
    final delegate = context.read<Scope>().router.chatDelegate;
    delegate.pages.add(AlterGroupNamePage(conversation: conversation));
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '群聊设置',
          style: Theme.of(context).textTheme.titleMedium,
        ).alignment(Alignment.centerLeft).padding(vertical: 4),
        InkWell(
          onTap: () => toAlterAvatar(context),
          borderRadius: BorderRadius.circular(8),
          child: Row(
            children: [
              ConversationAvatar(
                size: 72,
                conversation: conversation,
              ),
              const Text(
                '点击修改群聊头像',
                style: TextStyle(
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ).alignment(Alignment.centerRight).expanded(),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 12,
              ).padding(left: 4),
            ],
          ).padding(all: 16),
        ).padding(bottom: 4),
        ListTile(
          onTap: () => toAlterGroupName(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: const Text('群聊名称'),
          subtitle: Text(conversation.info.name),
        ).padding(bottom: 4),
      ],
    );
  }
}
