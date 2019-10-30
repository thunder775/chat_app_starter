import 'package:chat_app_starter/chat_screen.dart';
import 'package:chat_app_starter/login_screen.dart';
import 'package:chat_app_starter/message_bubble.dart';
import 'package:chat_app_starter/registration_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ChatScreen(),
  ));
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 250,
              width: 250,
              child: Hero(tag: 'collegeLogo',
                child: Image(
                  image: AssetImage('assets/college.png'),
                ),
              ),
            ),
            Center(
                child: Text(
              'McLaren Chat',
              style: TextStyle(
                  color: Color(0xFF0096FB), fontSize: 40, fontFamily: 'PlayfairDisplay'),
            )),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24, top: 24),
              child: SizedBox(
                height: 55,
                child: RaisedButton(
                  color: Color(0xFF0096FB),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24, top: 16),
              child: SizedBox(
                height: 55,
                child: RaisedButton(
                  color: Color(0xFFAA00B6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RegistrationScreen()));
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
