import 'package:chat_app_starter/main.dart';
import 'package:chat_app_starter/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  String roomID;

  ChatScreen({this.roomID});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();

  FirebaseUser user;

  @override
  void initState() {
    getUser();
    print('initstate ended');
    super.initState();
  }

  Future getUser() async {
    print('initialised');
    user = await FirebaseAuth.instance.currentUser();

    print(user.email);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image(image: AssetImage('assets/college.png')),
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
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('rooms')
                  .document('${widget.roomID}')
                  .collection('messages').orderBy('time')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Container(height: 50,width: 50,child: CircularProgressIndicator()));
                } else {
                  return ListView.builder(
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextBubble(
                          message: snapshot.data.documents[index].data['text'],
                          email: snapshot.data.documents[index].data['sender'],
                          isCurrentUser: user.email ==
                              snapshot.data.documents[index].data['sender'],
                        ),
                      );
                    },
                    itemCount: snapshot.data.documents.length,
                    shrinkWrap: true,
                  );
                }
              },
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      focusColor: Color(0xFF0096FB),
                      hintText: 'Enter your text here',
                      hintStyle: TextStyle(color: Colors.grey)),
                  onChanged: (String text) {},
                ),
              ),
              SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: controller.text.isEmpty?null:() async {
                        String temp = controller.text;
                        controller.clear();
                        Firestore.instance
                            .collection('rooms')
                            .document('${widget.roomID}')
                            .collection('messages').add({
                          'text':temp,
                          'sender': user.email,
                          'time' : DateTime.now()
                        });
                      },
                icon: Icon(Icons.send),
                color: Colors.blue,
              )
            ],
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
}
