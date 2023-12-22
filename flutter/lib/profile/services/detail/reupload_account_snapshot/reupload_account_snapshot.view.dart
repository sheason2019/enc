import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/contacts/search/search.controller.dart';
import 'package:ENC/scope/scope.model.dart';

class ReloadAccountSnapshotListTile extends StatelessWidget {
  final String url;
  const ReloadAccountSnapshotListTile({
    super.key,
    required this.url,
  });

  void handleUploadSnapshot(BuildContext context) async {
    final scope = context.read<Scope>();
    await scope.subscribes[url]?.handleUploadSnapshot();
  }

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();

    return FutureBuilder(
      future: SearchContactController.handleSearch(
        '$url/account/${scope.secret.signPubKey}',
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final localVersion = scope.snapshot.version;
          final remoteVersion = snapshot.requireData.version;
          final needSync = localVersion != remoteVersion;
          return ListTile(
            onTap: needSync ? () => handleUploadSnapshot(context) : null,
            title: Text(needSync ? '点击同步用户信息' : '用户信息已同步'),
            subtitle: Text(
              '用户信息版本：本地-V$localVersion '
              '服务器-V$remoteVersion',
            ),
          );
        }

        return const ListTile(
          title: Text('正在加载用户信息'),
          subtitle: SizedBox(),
        );
      },
    );
  }
}
