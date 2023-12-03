import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class ServiceDetailPage extends StatelessWidget {
  final String url;
  const ServiceDetailPage({super.key, required this.url});

  handleUploadSnapshot(BuildContext context) async {
    final scope = context.read<Scope>();
    await scope.subscribes[url]?.handleUploadSnapshot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(url),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () => handleUploadSnapshot(context),
            title: const Text('重新上传用户信息'),
            subtitle: const Text('服务器用户信息'),
          )
        ],
      ),
    );
  }
}
