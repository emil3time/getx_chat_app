import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_chat_app/app/modules/auth/controllers/auth_controller.dart';

import 'package:getx_chat_app/app/widgets/myMessage.dart';
import 'package:getx_chat_app/app/widgets/recieved_message.dart';

class MessageBubble extends GetView<AuthController> {
  final String message;
  final String messageUID;
  @override
  final Key key;

  late bool isMe = messageUID == controller.authorUID;
  MessageBubble(
      {required this.message, required this.messageUID, required this.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: isMe
            ? MyMessage(
                
                message: message,
                key: key,
              )
            : RecievedMessage(
                message: message,
                key: key,
              ));
  }
}
