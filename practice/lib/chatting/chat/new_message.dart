import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  var _message = '';
  final _uid = FirebaseAuth.instance.currentUser!.uid;

  void _sendToServer() async {
    try {
      final response = await Dio().post(
        'http://10.0.2.2:8000/api/chat/',
        data: {
          "uid": _uid,
        },
      );

      final aiResponse = response.data['response'];

      // Firestore에 AI 응답 저장
      FirebaseFirestore.instance
          .collection('chat')
          .doc(_uid)
          .collection('messages')
          .add({
        'text': aiResponse,
        'uid': 'ai',
        'time': Timestamp.now(),
      });
    } catch (error) {
      print("Error sending message: $error");
    }
  }

  void _sendMessage() {
    FirebaseFirestore.instance
        .collection('chat')
        .doc(_uid)
        .collection('messages')
        .add({
      'text': _message,
      'time': Timestamp.now(),
      'uid': FirebaseAuth.instance.currentUser!.uid,
    });

    _sendToServer();

    _controller.clear();
    setState(() {
      _message = '';
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  _message = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'sending message..',
              ),
              onSubmitted: (value) {
                if (_message.isNotEmpty) {
                  _sendMessage();
                }
                _focusNode.requestFocus();
              },
              focusNode: _focusNode,
            ),
          ),
          IconButton(
            onPressed: _message.isEmpty
                ? null
                : () {
                    _sendMessage();
                    _focusNode.requestFocus();
                  },
            icon: Icon(
              Icons.send,
              color: Color(
                  _message.isEmpty ? Colors.grey.value : Colors.blue.value),
            ),
          )
        ],
      ),
    );
  }
}
