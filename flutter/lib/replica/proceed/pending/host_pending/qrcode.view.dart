import 'dart:convert';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/replica/replica.controller.dart';

class ReplicaProceedHostPendingQrcode extends StatelessWidget {
  const ReplicaProceedHostPendingQrcode({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ReplicaController>();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: BarcodeWidget(
        barcode: Barcode.qrCode(
          errorCorrectLevel: BarcodeQRCorrectionLevel.medium,
        ),
        data: jsonEncode({
          'type': 'replica',
          'url': controller.url,
          'namespace': controller.namespace,
          'dataDirection': controller.dataDirection.name,
        }),
      ),
    );
  }
}
