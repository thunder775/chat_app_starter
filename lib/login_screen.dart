import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      child: Hero(tag: 'collegeLogo',
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
                          fontFamily: 'Rubik'),
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
                onChanged: (String text) {},
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 30, right: 24),
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
                onChanged: (String text) {},
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24, top: 24),
              child: SizedBox(
                height: 55,
                child: RaisedButton(
                  color: Color(0xFF0096FB),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  onPressed: () {},
                  child: Text(
                    'Login',
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
