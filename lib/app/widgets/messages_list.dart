import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_chat_app/app/modules/auth/controllers/auth_controller.dart';

class MessagesList extends GetView<AuthController> {
  const MessagesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat_app')
            .doc('XUabc2KTxL0jod7tPIv8')
            .collection('messages')
            .snapshots(),
        builder:
            (_, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return Expanded(
            child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, i) {
                  final documents = snapshot.data!.docs;

                  return ListTile(
                      leading: documents[i]['visible'] == true
                          ? Text(documents[i]['messageContent'])
                          : Text('the user will undo sending the message '),
                      trailing: IconButton(
                          onPressed: () {
                            snapshot.data!.docs[i].reference
                                .update({"visible": !documents[i]['visible']});
                          },
                          icon: Icon(Icons.hide_source)));
                }),
          );
        });
  }
}

//

//


 // if (snapshot.hasError) {
          //   return Center(child: Text('Something went wrong'));
          // }
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(child: CircularProgressIndicator());
          // }

          // return ListView(
          //   children: snapshot.data!.docs.map((e) {
          //     Map<String, dynamic> data = e.data();
          //     return Center(
          //       child: ListTile(
          //         leading: Text(data['messageContent']),
          //       ),
          //     );
          //   }).toList(),
          // );