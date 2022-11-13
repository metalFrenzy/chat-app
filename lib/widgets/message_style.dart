import 'package:flutter/material.dart';

class MessageStyle extends StatelessWidget {
  final message;
  final bool isMe;
  final key;
  final String username;
  final String imageUrl;

  MessageStyle(
    this.message,
    this.isMe,
    this.username,
    this.imageUrl, {
    this.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: 140,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 6,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
                color: isMe
                    ? Color.fromARGB(255, 98, 35, 208)
                    : Color.fromARGB(255, 240, 98, 146),
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).accentTextTheme.headline1!.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -10,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
      ],
    );
  }
}
