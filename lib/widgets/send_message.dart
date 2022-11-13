import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SendMessage extends StatefulWidget {
  const SendMessage({super.key});

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  var _message = '';
  final _controller = new TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      FirebaseFirestore.instance.collection('chat').add({
        'text': _message,
        'createdAt': Timestamp.now(),
        'userId': user.uid,
        'username': userData['username'],
        'imageUrl': userData['user-images'],
      });
    } catch (error) {
      print(error);
    }

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'send a message...'),
              onChanged: (value) {
                setState(() {
                  _message = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            onPressed: _message.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send_rounded),
          )
        ],
      ),
    );
  }
}
