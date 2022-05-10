import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_chat_app/app/modules/auth/controllers/auth_controller.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  final authContr = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                authContr.signOut();
              },
              child: Text('Log Out',style: TextStyle(color: Colors.white),))
        ],
        title: Text('ChatView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chat_app')
                .doc('XUabc2KTxL0jod7tPIv8')
                .collection('messages')
                .snapshots(),
            builder: (_,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView(
                children: snapshot.data!.docs.map((e) {
                  Map<String, dynamic> data = e.data();
                  return Center(
                    child: ListTile(
                      leading: Text(data['text']),
                    ),
                  );
                }).toList(),
              );

              // if (snapshot.hasError) {
              //   return Center(child: Text('Something went wrong'));
              // }
              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return Center(child: CircularProgressIndicator());
              // }

              // return ListView.builder(
              //     itemCount: snapshot.data!.docs.length,
              //     itemBuilder: (context, i) {
              //       final documents = snapshot.data!.docs;

              //       return Center(
              //         child: ListTile(
              //           leading: Text(documents[i]['text']),
              //         ),
              //       );
              //     });
            }),
      ),
    );
  }
}
