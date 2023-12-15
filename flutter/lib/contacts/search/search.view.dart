import 'package:flutter/material.dart';
import 'package:sheason_chat/contacts/search/search.controller.dart';
import 'package:styled_widget/styled_widget.dart';

class SearchContactPage extends StatefulWidget {
  const SearchContactPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchContactPageState();
}

class _SearchContactPageState extends State<SearchContactPage> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  handleSubmit() async {
    final url = textController.text;
    await SearchContactController.handleSearch(context, url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('搜索网络联系人'),
      ),
      body: TextField(
        controller: textController,
        decoration: const InputDecoration(
          label: Text('输入用户 URL'),
        ),
        onSubmitted: (_) => handleSubmit(),
      ).padding(vertical: 12).width(380).center(),
      floatingActionButton: FloatingActionButton(
        onPressed: handleSubmit,
        child: const Icon(Icons.check),
      ),
    );
  }
}
