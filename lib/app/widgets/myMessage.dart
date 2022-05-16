import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_chat_app/app/modules/auth/controllers/auth_controller.dart';

import 'custom_shape.dart';

class MyMessage extends GetView<AuthController> {
  final String message;

  @override
  final Key key;

  MyMessage({required this.message, required this.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.cyan[900],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('chat_app')
                        .doc('XUabc2KTxL0jod7tPIv8')
                        .collection('users_collection')
                        .doc(controller.authorUID)
                        .get(),
                    builder: (BuildContext _,
                        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('error'),
                        );
                      }

                      return Text(snapshot.data!['name'] ,style: TextStyle(color: Colors.white24,fontSize: 10),);
                    }),
                Text(
                  message,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        CustomPaint(painter: CustomShape(Colors.cyan[900]!)),
      ],
    ));
  }
}
