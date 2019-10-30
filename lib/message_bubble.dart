import 'package:flutter/material.dart';

class TextBubble extends StatefulWidget {
  bool isCurrentUser ;
  String message;
  String email;
  TextBubble({this.isCurrentUser = true,this.email = 'null',this.message = 'null'});
  @override
  _TextBubbleState createState() => _TextBubbleState();
}

class _TextBubbleState extends State<TextBubble>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curve;


  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
      value: 0,
    );
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  BoxDecoration currentUserDecoration() {
    return BoxDecoration(
        color: Colors.blue,
//        border: Border.all(),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            topLeft: Radius.circular(50),
            bottomRight: Radius.circular(50)));
  }

  BoxDecoration anotherUserDecoration() {
    return BoxDecoration(
        color: Color(0xFFF6F6F6),
//        border: Border.all(),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            topRight: Radius.circular(50),
            bottomRight: Radius.circular(50)));
  }
  TextStyle currentUserStyle(){
    return TextStyle(
      color: Colors.white,
      fontSize: 20,
    );
  }
  TextStyle anotherUserStyle(){
    return TextStyle(
      color: Color(0xFFA5A7AA),
      fontSize: 20,
    );
  }


//  CrossAxisAlignment start
  @override
  Widget build(BuildContext context) {
    curve = CurvedAnimation(curve: Curves.bounceOut, parent: controller);
    return SafeArea(
      child: Column(
        crossAxisAlignment: widget.isCurrentUser?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.email,
              style: TextStyle(
                color: Color(0xFFA5A7AA),
                fontSize: 14,
              )),
          ScaleTransition(
            scale: Tween(begin: 0.0, end: 1.0).animate(curve),
            child: Container(
//                  height: 50,
              decoration: widget.isCurrentUser?currentUserDecoration():anotherUserDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.message,
                  style:widget.isCurrentUser?currentUserStyle():anotherUserStyle(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
