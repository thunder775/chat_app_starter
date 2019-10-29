import 'package:chat_app_starter/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0096FB),
        title: Text(
          'Chat',
          style: TextStyle(
            fontSize: 25,
            letterSpacing: 2,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.power_settings_new,
              color: Colors.white,
            ),
            onPressed: () {
              try {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
              } catch (e) {
                print(e);
              }
              print('hey');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.file_download,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                width: 200,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusColor: Color(0xFF0096FB),
                      hintText: 'Enter your text here',
                      hintStyle: TextStyle(color: Color(0xFF898989))),
                  onChanged: (String text) {},
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              backgroundColor: Color(0xFFAA00B6),
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
