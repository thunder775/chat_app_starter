import 'package:chat_app_starter/main.dart';
import 'package:chat_app_starter/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  FirebaseUser user;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();
  List<Widget> Messages = [];

  @override
  void initState() {
    getUser();
    print('initstate ended');
    super.initState();
  }

  Future getUser() async {
    print('initialised');
    widget.user = await FirebaseAuth.instance.currentUser();
    print(widget.user.email);
    controller.addListener(() {
      setState(() {});
    });
  }

  void getMessages() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print('user isssss -----------${user.email}');
    QuerySnapshot messages =
        await Firestore.instance.collection('messages').getDocuments();
    setState(() {
      Messages = [];
      for (int i = 0; i < messages.documents.length; i++) {
        print('fetched user ${messages.documents[i]['sender']}');
        if (messages.documents[i]['sender'] == user.email) {
          print('into true case');
          Messages.add(TextBubble(
            isCurrentUser: true,
            email: messages.documents[i]['sender'],
            message: messages.documents[i]['text'],
          ));
        } else {
          print('into false case');
          Messages.add(TextBubble(
            isCurrentUser: false,
            email: messages.documents[i]['sender'],
            message: messages.documents[i]['text'],
          ));
        }
      }
    });
  }

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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));
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
            onPressed: () {
              getMessages();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: Messages,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: 200,
                    child: TextField(
                      controller: controller,
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
                  child: IconButton(
                    onPressed: controller.text.isEmpty
                        ? null
                        : () async {
                            await Firestore.instance
                                .collection('messages')
                                .add({
                              'sender': widget.user.email,
                              'text': controller.text
                            });
                            controller.clear();
                            getMessages();
                          },
                    icon: Icon(Icons.send),
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
