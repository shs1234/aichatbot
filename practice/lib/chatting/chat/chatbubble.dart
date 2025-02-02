import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.isSentByMe,
    required this.text,
  });

  final bool isSentByMe;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          decoration: BoxDecoration(
            color: isSentByMe ? Colors.blue[100] : Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: isSentByMe ? Radius.circular(12) : Radius.zero,
              bottomRight: isSentByMe ? Radius.zero : Radius.circular(12),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
