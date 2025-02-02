import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice/chatting/chat/chatbubble.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final _store = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _store
          .collection('chat')
          .doc(_auth.currentUser!.uid)
          .collection('messages')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final docs = snapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (context, index) {
            return ChatBubble(
                isSentByMe: _auth.currentUser!.uid == docs[index]['uid'],
                text: docs[index]['text']);
          },
        );
      },
    );
  }
}
