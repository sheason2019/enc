import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/profile/services/detail/resource/resource.controller.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:ENC/utils/string_helper.dart';
import 'package:styled_widget/styled_widget.dart';

class ServiceResourcePage extends StatefulWidget {
  final String url;
  const ServiceResourcePage({super.key, required this.url});

  @override
  State<StatefulWidget> createState() => _ServiceResourcePageState();
}

class _ServiceResourcePageState extends State<ServiceResourcePage> {
  final controller = ServiceResourceController();

  @override
  void initState() {
    controller.initial(widget.url, context.read<Scope>());
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        if (!controller.inited) {
          return Scaffold(
            appBar: AppBar(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('查看服务器资源使用情况'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '用户资源使用情况',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ).padding(horizontal: 16),
              ListTile(
                title: _UsageLabelBuilder(
                  label: '磁盘使用量',
                  used: controller.accountUsed,
                  total: controller.accountTotal,
                ),
                subtitle: LinearProgressIndicator(
                  value: controller.accountPercent,
                ),
              ),
              const Text(
                '服务器资源使用情况',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ).padding(horizontal: 16),
              ListTile(
                title: _UsageLabelBuilder(
                  label: '内存使用量',
                  used: controller.totalMem - controller.freeMem,
                  total: controller.totalMem,
                ),
                subtitle: LinearProgressIndicator(
                  value: 1 - (controller.freeMem / controller.totalMem),
                ),
              ),
              ListTile(
                title: _UsageLabelBuilder(
                  label: '磁盘使用量',
                  used: controller.totalDisk - controller.freeDisk,
                  total: controller.totalDisk,
                ),
                subtitle: LinearProgressIndicator(
                  value: 1 - (controller.freeDisk / controller.totalDisk),
                ),
              ),
              ListTile(
                title: _UsageLabelBuilder(
                  label: 'CPU 使用量',
                  used: controller.totalCpuTime - controller.idleCpuTime,
                  total: controller.totalCpuTime,
                  showPercent: true,
                ),
                subtitle: LinearProgressIndicator(
                  value: 1 - (controller.idleCpuTime / controller.totalCpuTime),
                ),
              ),
              ListTile(
                title: _UsageLabelBuilder(
                  label: '用户在线情况',
                  used: controller.onlineAccount,
                  total: controller.totalAccount,
                  transString: false,
                ),
                subtitle: LinearProgressIndicator(
                  value: controller.onlineAccount / controller.totalAccount,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _UsageLabelBuilder extends StatelessWidget {
  final String label;
  final int used;
  final int? total;
  final bool showPercent;
  final bool transString;
  const _UsageLabelBuilder({
    required this.label,
    required this.used,
    required this.total,
    this.showPercent = false,
    this.transString = true,
  });

  String get totalStr {
    if (total == null) {
      return '不限';
    } else if (transString) {
      return StringHelper.fileSize(total!);
    } else {
      return total!.toString();
    }
  }

  String get progressStr {
    if (showPercent) {
      if (total == null) {
        return '0';
      } else {
        final percent = (used / total!) * 100;
        return '${percent.toStringAsFixed(2)} %';
      }
    } else if (transString) {
      return '${StringHelper.fileSize(used)} / $totalStr';
    } else {
      return '$used / $totalStr';
    }
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: label),
          const WidgetSpan(child: SizedBox(width: 16)),
          TextSpan(
            text: progressStr,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ],
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
