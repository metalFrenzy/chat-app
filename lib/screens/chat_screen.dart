import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/messages.dart';
import '../widgets/send_message.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout),
            label: Text('Logout'),
          )
        ],
        title: Text(
          'Chats',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Times new Roman',
            fontSize: 25,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            SendMessage(),
          ],
        ),
      ),
    );
  }
}
