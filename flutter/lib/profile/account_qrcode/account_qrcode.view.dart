import 'dart:convert';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ENC/accounts/account_avatar.view.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:ENC/utils/service_selector/service_selector.controller.dart';
import 'package:ENC/utils/service_selector/service_selector.view.dart';
import 'package:styled_widget/styled_widget.dart';

class AccountQrCodePage extends StatefulWidget {
  const AccountQrCodePage({super.key});

  @override
  State<StatefulWidget> createState() => _AccountQrCodePageState();
}

class _AccountQrCodePageState extends State<AccountQrCodePage> {
  late final controller = ServiceSelectorController(
    context.read<Scope>(),
  );

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('账号二维码'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            leading: AccountAvatar(snapshot: scope.snapshot),
            title: Text(scope.snapshot.username),
          ).padding(bottom: 8),
          ServiceSelector(controller: controller).padding(horizontal: 48),
          if (controller.serviceUrl != null) ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: ListenableBuilder(
                listenable: controller,
                builder: (context, _) {
                  final url =
                      '${controller.serviceUrl}/account/${scope.secret.signPubKey}';
                  return InkWell(
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(text: url));
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('复制成功'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    child: BarcodeWidget(
                      barcode: Barcode.qrCode(
                        errorCorrectLevel: BarcodeQRCorrectionLevel.quartile,
                      ),
                      data: jsonEncode({
                        'type': 'account',
                        'url': url,
                      }),
                    ),
                  ).aspectRatio(aspectRatio: 1).padding(all: 16);
                },
              ),
            ),
            const Text(
              '使用扫一扫功能扫描二维码添加用户',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ] else
            const Text(
              '请先选择服务器',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
        ],
      )
          .padding(bottom: 24, top: 12)
          .card()
          .constrained(maxWidth: 360)
          .padding(horizontal: 16)
          .center(),
    );
  }
}
