import 'package:flutter/material.dart';

import 'service_selector.controller.dart';

class ServiceSelector extends StatelessWidget {
  final ServiceSelectorController controller;

  const ServiceSelector({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => DropdownButton<String>(
        isExpanded: true,
        value: controller.serviceUrl,
        hint: const Text('点击选择托管静态资源的服务器'),
        onChanged: (v) {
          controller.serviceUrl = v;
        },
        items: [
          for (final service in controller.services)
            DropdownMenuItem(
              value: service,
              child: Text(service),
            ),
        ],
      ),
    );
  }
}
