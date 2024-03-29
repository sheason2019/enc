import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ENC/chat/room/room.controller.dart';
import 'package:ENC/dio.dart';
import 'package:ENC/models/rtc_model.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/utils/service_selector/service_selector.controller.dart';
import 'package:ENC/utils/sign_helper.dart';
import 'package:uuid/uuid.dart';

class CreateRTCInviteController extends ChangeNotifier {
  final ChatController chatController;
  CreateRTCInviteController({required this.chatController});

  late final serviceController = ServiceSelectorController(
    chatController.scope,
  );

  int get joinLimit => _joinLimit;
  set joinLimit(int value) {
    _joinLimit = value;
    notifyListeners();
  }

  int _joinLimit = 0;

  Future<void> handleSubmit() async {
    final url = serviceController.serviceUrl!;
    final rtcModel = RtcModel(
      name: '',
      uuid: const Uuid().v4(),
      serviceUrl: url,
    );

    final buffer = utf8.encode(jsonEncode(rtcModel.toJson()));

    final wrapper = await SignHelper.wrap(
      chatController.scope,
      buffer,
      contentType: ContentType.CONTENT_BUFFER,
    );
    final data = FormData.fromMap({
      'payload': base64Encode(wrapper.writeToBuffer()),
    });
    final resp = await dio.post(
      '$url/rtc',
      data: data,
    );
    final receiveRtcModel = RtcModel.fromJson(resp.data);
    final message = await chatController.inputController.createMessage();
    message.messageType = MessageType.MESSAGE_TYPE_RTC;
    message.content = jsonEncode(receiveRtcModel.toJson());

    await chatController.inputController.sendMessage([message]);
    await chatController.messagesController.handleNextTickToBottom();
  }

  @override
  void dispose() {
    serviceController.dispose();
    super.dispose();
  }
}
