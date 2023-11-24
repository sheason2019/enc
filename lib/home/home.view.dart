import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheason_chat/home/home.controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sheason Chat'),
      ),
      body: const LinearProgressIndicator(),
    );
  }
}
