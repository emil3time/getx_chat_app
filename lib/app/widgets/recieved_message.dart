import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_chat_app/app/modules/auth/controllers/auth_controller.dart';
import 'dart:math' as math;
import 'package:getx_chat_app/app/widgets/custom_shape.dart';

class RecievedMessage extends GetView<AuthController> {
  @override
  final Key key;
  final String message;
  final String messageUID;
  final String name;

  RecievedMessage(
      {required this.message,
      required this.messageUID,
      required this.name,
      required this.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: CustomPaint(
            painter: CustomShape(Colors.grey[300]!),
          ),
        ),
        Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(),
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  name,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
                ),
                Text(
                  message,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}


//  FutureBuilder(
//                     future: FirebaseFirestore.instance
//                         .collection('chat_app')
//                         .doc('XUabc2KTxL0jod7tPIv8')
//                         .collection('users_collection')
//                         .doc(messageUID)
//                         .get(),
//                     builder: (BuildContext _,
//                         AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
//                             snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//                       if (snapshot.hasError) {
//                         return Center(
//                           child: Text('error'),
//                         );
//                       }

//                       return Text(
//                         snapshot.data!['name'],
//                         style: TextStyle(color: Colors.black26, fontSize: 10),
//                       );
//                     }),