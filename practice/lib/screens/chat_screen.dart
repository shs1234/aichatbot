import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice/chatting/chat/messages.dart';
import 'package:practice/chatting/chat/new_message.dart';
import 'package:practice/screens/my_profile.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('chat room'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _auth.signOut();
            },
          ),
          actions: [
            IconButton(
              icon: CircleAvatar(
                backgroundImage: AssetImage('assets/images/default_avatar.png'),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyProfile()));
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ));
  }
}
