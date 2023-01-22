import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../Pages/JournalEntry.dart';

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
            style: GoogleFonts.redHatDisplay(textStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 45)),
            textAlign: TextAlign.center,
          ),
          Container(height: 15,),
          SimpleFlatButton(
                  text: "LOGIN",
                  inputFunc: () {
                    Navigator.pop(context);
                  }),
          
        ],
      ),
    );
  }
}
