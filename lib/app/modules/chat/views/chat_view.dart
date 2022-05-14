import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_chat_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:getx_chat_app/app/widgets/message_sender.dart';

import '../../../widgets/messages_list.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  final authContr = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
              onPressed: () {
                authContr.signOut();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              label: Text(
                'Log Out',
                style: TextStyle(color: Colors.white),
              ))
        ],
        title: Text('ChatView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            MessagesList(),
            SizedBox(height: 5),
            MessageSender(),
          ],
        ),
      ),
    );
  }
}






// service cloud.firestore {
//   match /databases/{database}/documents {
//     match /cities/{city} {
//       // Make sure a 'users' document exists for the requesting user before
//       // allowing any writes to the 'cities' collection
//       allow create: if request.auth != null && exists(/databases/$(database)/documents/users/$(request.auth.uid))

//       // Allow the user to delete cities if their user document has the
//       // 'admin' field set to 'true'
//       allow delete: if request.auth != null && get(/databases/$(database)/documents/users/$(request.auth.uid)).data.admin == true
//     }
//   }
// }
