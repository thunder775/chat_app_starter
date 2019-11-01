import 'package:chat_app_starter/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _saving = false;
  String email;
  String password;
  String errorText='';

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
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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
                      'Register',
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
              padding: const EdgeInsets.only(left: 16.0, top: 30, right: 24, bottom: 30),
              child: TextField(
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
            ), Center(
                child: Text(
                  errorText,
                  style: TextStyle(color: Colors.red),
                )),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24, top: 0),
              child: SizedBox(
                height: 55,
                child: RaisedButton(
                  color: Color(0xFFAA00B6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  onPressed: () async {

                    try {
                      isSaving();
                      AuthResult result = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: email, password: password);

                      if (result.user != null) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      }
                    } catch (e) {
                      setState(() {
                        errorText = 'Enter a valid Email and Password';
                      });
                      doneSaving();
                      print(e);
                    }
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
