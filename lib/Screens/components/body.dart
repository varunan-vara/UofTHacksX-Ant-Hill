import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/components/body.dart';
import 'package:flutter_application/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "WELCOME TO ANTHILL",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Container(
            width: size.width * 2.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: SimpleFlatButton(text: "LOGIN", inputFunc: () {}),
            ),
          )
        ],
      ),
    );
  }
}

class SimpleFlatButton extends StatelessWidget {
  final String text;
  final Function inputFunc;
  const SimpleFlatButton(
      {Key? key, required this.text, required this.inputFunc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        inputFunc();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color(0xffB786E5),
        ),
        child: Text(
          "$text",
          style: TextStyle(color: Colors.white, fontSize: 13.0),
        ),
      ),
    );
  }
}
