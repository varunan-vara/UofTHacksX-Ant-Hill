import 'package:ant_hill/Widgets/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          NewAppBar(isSettings: false, contextData: context),
          SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SubAppBar(text: "Settings"),
              SettingsButton(
                title: "Add Activity",
                func: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        String value = "";
                        return AlertDialog(
                          title: Text("Add new activity"),
                          content: TextField(
                            onChanged: (x) {
                              setState(() {
                                value = x;
                              });
                            },
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel")),
                            TextButton(
                                onPressed: () {
                                  Future<void> setterFunc() async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    setState(() {
                                      List<String> x = prefs.getStringList(
                                              "dropdownActivities") ??
                                          [];
                                      x.add(value);
                                      prefs.setStringList(
                                          "dropdownActivities", x);
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                                child: Text("Submit"))
                          ],
                        );
                      });
                },
              ),
              SettingsButton(
                title: "Exit Settings",
                func: () {
                Navigator.pop(context);
              })
            ],
          )),
        ],
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({Key? key, required this.title, required this.func}) : super(key: key);
  final Function func;
  final String title;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                "$title",
                style: GoogleFonts.redHatDisplay(
                    textStyle: TextStyle(color: Colors.black, fontSize: 16)),
              ),
            ],
          )),
    );
  }
}
