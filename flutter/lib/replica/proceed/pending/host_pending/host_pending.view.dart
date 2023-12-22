import 'package:flutter/material.dart';
import 'package:ENC/replica/proceed/pending/host_pending/qrcode.view.dart';
import 'package:ENC/replica/proceed/pending/host_pending/text.view.dart';

class ReplicaProceedHostPending extends StatefulWidget {
  const ReplicaProceedHostPending({super.key});

  @override
  State<StatefulWidget> createState() => _ReplicaProceedHostPendingState();
}

class _ReplicaProceedHostPendingState extends State<ReplicaProceedHostPending> {
  var useQrCode = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SegmentedButton<bool>(
            onSelectionChanged: (v) {
              setState(() {
                useQrCode = v.first;
              });
            },
            segments: const [
              ButtonSegment(
                value: true,
                label: Text('二维码'),
              ),
              ButtonSegment(
                value: false,
                label: Text('校验码'),
              ),
            ],
            selected: {useQrCode},
          ),
          Card(
            margin: const EdgeInsets.only(top: 16),
            child: SizedBox(
              width: 256,
              height: 256,
              child: useQrCode
                  ? const ReplicaProceedHostPendingQrcode()
                  : const ReplicaProceedHostPendingText(),
            ),
          ),
        ],
      ),
    );
  }
}
