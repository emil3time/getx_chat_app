import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_chat_app/app/modules/auth/controllers/auth_controller.dart';

class MessageSender extends GetView<AuthController> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Form(
        key: _key,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                  controller: controller.messageController,
                  validator: (value) => controller.messageValidator(value!)),
            ),
            IconButton(
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    try {
                      await controller.saveMessage();
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                icon: Icon(Icons.sledding_rounded))
          ],
        ),
      ),
    );
  }
}
