import 'package:flutter/material.dart';
import 'package:sheason_chat/replica/import/import.controller.dart';

class ImportReplicaPage extends StatefulWidget {
  final String url;
  final String socketId;

  const ImportReplicaPage({
    super.key,
    required this.url,
    required this.socketId,
  });

  @override
  State<StatefulWidget> createState() => _ImportReplicaPageState();
}

class _ImportReplicaPageState extends State<ImportReplicaPage> {
  late final controller = ImportReplicaController(
    url: widget.url,
    socketId: widget.socketId,
  );

  @override
  void initState() {
    controller.handleConnect(context);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('生成账号副本'),
      ),
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Center(
            child: CircularProgressIndicator(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  leading: const CircleAvatar(),
                  title: Text(
                    controller.snapshot.username,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    controller.snapshot.index.signPubKey,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: controller.verifyCode.isNotEmpty
                        ? Text('验证码 ${controller.verifyCode}')
                        : FilledButton(
                            onPressed: controller.handleRequest,
                            child: const Text('请求传输账号副本'),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
