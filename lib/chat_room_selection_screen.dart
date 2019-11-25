import 'dart:math';
import 'package:flutter/services.dart';
import 'package:chat_app_starter/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChatRoomScreen extends StatefulWidget {
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  bool isValidID = true;
  List chatRooms = [];
  int chatID;
  int newID;
  Random ran = new Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image(
          image: AssetImage('assets/college.png'),
        ),
        title: Text('Select your chat Room'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: FloatingActionButton.extended(
                heroTag: 'new',
                onPressed: () {
                  newID = 999999 + ran.nextInt(9999999 - 999999);
                  print(newID);
                  Firestore.instance
                      .collection('rooms')
                      .document('$newID')
                      .setData({'id': newID});
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                roomID: '$newID',
                              )));
                },
                label: Text('New Chat Room'),
                icon: Icon(Icons.add),
              ),
            ),
          ),
          Center(
            child: FloatingActionButton.extended(
              heroTag: 'join',
              backgroundColor: Color(0xFFAA00B6),
              onPressed: () {
                return Alert(
                    context: context,
                    title: 'Chat Room ID',
                    content: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          icon: Icon(Icons.account_circle),
                          labelText: 'enter your ID here'),
                      onChanged: (String text) {
                        chatID = int.parse(text);
                      },
                    ),
                    buttons: [
                      DialogButton(
                        onPressed: () {
                          if (chatRooms.contains(chatID)) {
                            isValidID = true;
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                          roomID: '$chatID',
                                        )));
                          } else {
                            setState(() {
                              isValidID = false;
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          'JOIN',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ]).show();
              },
              label: Text('Join A Chat Room'),
              icon: Icon(Icons.people),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Center(
                  child: isValidID
                      ? null
                      : Text(
                          'Enter a valid Room ID!',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        )),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('rooms')
                  .orderBy('id')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Container(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator()));
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      chatRooms.add(snapshot.data.documents[index].data['id']);
                      return Card(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              trailing: IconButton(
                                icon: Icon(Icons.content_copy,),
                                onPressed: () {
                                  Clipboard.setData(new ClipboardData(
                                      text:
                                          '${snapshot.data.documents[index].data['id']}'));
                                },
                              ),
                              leading: Icon(Icons.people),
                              title: Text(
                                  '${snapshot.data.documents[index].data['id']}'),
                            ),
                          ],
                        ),
                      );
                    },
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
