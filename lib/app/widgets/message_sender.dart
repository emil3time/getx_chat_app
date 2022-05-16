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
                validator: (value) => controller.messageValidator(value!),


                style: TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
                decoration: InputDecoration(
                 hintText: 'message',
                  hintStyle: TextStyle(color: Colors.white24),
                    filled: true,
                    fillColor: Colors.white30,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: Colors.white24),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
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
              icon: Icon(Icons.send_outlined),
              color: Colors.white,
              iconSize: 40,
            )
          ],
        ),
      ),
    );
  }
}
