import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewAppBar extends StatelessWidget {
  const NewAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: 90 + statusbarHeight,
      child: Row(
        children: <Widget>[
          
        ],
      ),
    );
  }
}

class SubAppBar extends StatelessWidget {
  const SubAppBar({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "$text",
        style: GoogleFonts.redHatDisplay (
          textStyle: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: Color(0xff000000)),
        ),
        
      ),
    );
  }
}
