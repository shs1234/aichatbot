import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;
  final _nicknameController = TextEditingController();
  String _userName = '';

  Future<void> _getProfile() async {
    final userDoc =
        await _store.collection('user').doc(_auth.currentUser!.uid).get();
    setState(() {
      _userName = userDoc['userName'];
    });
  }

  Future<void> _updateNickname() async {
    final newNickname = _nicknameController.text;
    await _store
        .collection('user')
        .doc(_auth.currentUser!.uid)
        .update({'userName': newNickname});
    setState(() {
      _userName = newNickname;
    });
  }

  Future<void> _showNicknameDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: TextField(
            controller: _nicknameController,
            decoration: InputDecoration(
              labelText: '새로운 닉네임',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                _updateNickname();
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/default_avatar.png'),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('사진 변경'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('사진 삭제'),
                ),
              ],
            ),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '닉네임 : ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _userName,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showNicknameDialog();
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.grey,
                    size: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
