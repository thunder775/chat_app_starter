
import 'package:chat_app_starter/chat_room_selection_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String errorText = '';
  bool _saving = false;
  String email;
  String password;

  void isSaving() async {
    setState(() {
      _saving = true;
    });
  }

  void doneSaving() async {
    setState(() {
      _saving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ModalProgressHUD(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 60,),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          child: Hero(
                            tag: 'collegeLogo',
                            child: Image(
                              image: AssetImage('assets/college.png'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Color(0xFF0096FB),
                              fontSize: 40,
                              fontFamily: 'PlayfairDisplay'),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 30, right: 24),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(
                          Icons.mail,
                          size: 35,
                          color: Color(0xFF898989),
                        ),
                        hintText: 'thunder@775.com',
                        hintStyle: TextStyle(color: Color(0xFF898989))),
                    onChanged: (String text) {
                      email = text;
                    },
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, top: 30, right: 24, bottom: 30),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(
                          Icons.lock,
                          size: 35,
                          color: Color(0xFF898989),
                        ),
                        hintText: 'boanerges',
                        hintStyle: TextStyle(color: Color(0xFF898989))),
                    onChanged: (String text) {
                      password = text;
                    },
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                    child: Text(
                  errorText,
                  style: TextStyle(color: Colors.red),
                )),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    right: 24,
                  ),
                  child: SizedBox(
                    height: 55,
                    child: RaisedButton(
                      color: Color(0xFF0096FB),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      onPressed: () async {
                        isSaving();
                        try {
                          AuthResult result = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email, password: password);
                          if (result.user != null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatRoomScreen()));
                            doneSaving();
                          }
                        } catch (e) {
                          setState(() {
                            errorText = 'Please check your Email and Password';
                          });
                          doneSaving();
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            ),
            inAsyncCall: _saving,
          ),
        ),
      ),
    );
  }
}
