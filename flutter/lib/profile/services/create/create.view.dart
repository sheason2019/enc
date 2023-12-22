import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/dio.dart';
import 'package:ENC/main.controller.dart';
import 'package:ENC/profile/services/create/confirm.view.dart';
import 'package:ENC/prototypes/core.pb.dart';

class CreateServicePage extends StatefulWidget {
  const CreateServicePage({super.key});
  @override
  State<StatefulWidget> createState() => _CreateServicePageState();
}

class _CreateServicePageState extends State<CreateServicePage> {
  final controller = TextEditingController();

  handleNextStep() async {
    final delegate = context.read<MainController>().rootDelegate;
    final uri = Uri.parse(controller.text);
    if (!uri.isAbsolute) {
      throw Exception('input data is not url');
    }
    var url = uri.toString();
    if (url.endsWith('/')) {
      url = url.substring(0, url.length - 1);
    }

    try {
      final resp = await dio.get(url);
      final service = PortableService.fromBuffer(base64Decode(resp.data));
      delegate.pages.add(ConfirmCreateServicePage(service: service, url: url));
      delegate.notify();
    } catch (e) {
      debugPrint('搜索服务器失败 $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新建服务器'),
      ),
      body: Center(
        child: SizedBox(
          width: 360,
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 16,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  label: Text('服务器 Url'),
                ),
              ),
              FilledButton(
                onPressed: handleNextStep,
                child: const Text('下一步'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
