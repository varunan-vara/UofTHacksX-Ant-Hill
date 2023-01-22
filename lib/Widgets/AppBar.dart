import 'package:ant_hill/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Pages/Settings.dart';

class NewAppBar extends StatelessWidget {
  NewAppBar({Key? key, required this.isSettings, required this.contextData})
      : super(key: key);
  final bool isSettings;
  final BuildContext contextData;
  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: 90 + statusbarHeight,
      child: Row(
        children: <Widget>[
          Container(width: 4),
          isSettings
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsScreen()));
                  },
                  icon: Icon(Icons.settings),
                  iconSize: 30,
                )
              : Container(),
          Spacer(),
          TextButton(
            child: Text(
              "Log out",
              style: GoogleFonts.redHatDisplay(
                  textStyle: TextStyle(color: Colors.black)),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()));
            },
          ),
          Container(width: 4),
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
        style: GoogleFonts.redHatDisplay(
          textStyle: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: Color(0xff000000)),
        ),
      ),
    );
  }
}
