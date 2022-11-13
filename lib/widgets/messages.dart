import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/message_style.dart';

class Messages extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chats = snapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chats.length,
          itemBuilder: (context, index) => MessageStyle(
            chats[index]['text'],
            chats[index]['userId'] == user!.uid,
            chats[index]['username'],
            chats[index]['imageUrl'],
            key: UniqueKey(),
          ),
        );
      },
    );
  }
}
