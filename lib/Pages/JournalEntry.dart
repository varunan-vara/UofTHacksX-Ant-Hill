import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Widgets/AppBar.dart';
import 'package:multiselect/multiselect.dart';
import '../Code/firebase_accessor.dart';

class JournalEntry extends StatefulWidget {
  JournalEntry({Key? key}) : super(key: key);

  @override
  State<JournalEntry> createState() => _JournalEntryState();
}

class _JournalEntryState extends State<JournalEntry> {
  int selected = 3;
  String journalEntry = "";
  List<String> activityDropdown = [];
  List<String> activitySelected = [];
  List<String> moodsSelected = [];
  String dropdownSelect = "None";
  Future<void> tempLoader() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setStringList("dropdownActivities", [
        "Exams",
        "Midterms",
        "Assignments",
        "Piano Practice",
        "Play Basketball",
        "Coding",
        "Video Games"
      ]);
    });
  }

  Future<void> getActivityOpts() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      activityDropdown = prefs.getStringList("dropdownActivities") ?? ["Error"];
    });
  }

  @override
  Widget build(BuildContext context) {
    tempLoader();
    getActivityOpts();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          NewAppBar(
            isSettings: false,
            contextData: context,
          ),
          SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SubAppBar(text: "New Journal"),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    JournalQuestion(text: "Decribe how you felt today:"),
                    TextField(
                      textCapitalization: TextCapitalization.sentences,
                      minLines: 10,
                      maxLines: 10,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          journalEntry = value;
                        });
                      },
                    ),
                    JournalQuestion(text: "\nRate your day:"),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          EmojiButton(
                              text: "😟",
                              isSelected: (selected == 0),
                              func: () {
                                setState(() {
                                  selected = 0;
                                });
                              }),
                          EmojiButton(
                              text: "🫤",
                              isSelected: (selected == 1),
                              func: () {
                                setState(() {
                                  selected = 1;
                                });
                              }),
                          EmojiButton(
                              text: "😐",
                              isSelected: (selected == 2),
                              func: () {
                                setState(() {
                                  selected = 2;
                                });
                              }),
                          EmojiButton(
                              text: "😀",
                              isSelected: (selected == 3),
                              func: () {
                                setState(() {
                                  selected = 3;
                                });
                              }),
                          EmojiButton(
                              text: "😁",
                              isSelected: (selected == 4),
                              func: () {
                                setState(() {
                                  selected = 4;
                                });
                              })
                        ],
                      ),
                    ),
                    JournalQuestion(text: "\nSelect your activity tags:"),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: DropDownMultiSelect(
                          onChanged: (List<String> x) {
                            setState(() {
                              activitySelected = x;
                            });
                          },
                          options: activityDropdown,
                          selectedValues: activitySelected,
                          whenEmpty: "",
                        )),
                    JournalQuestion(
                        text:
                            "\nSelect any of the following moods that may apply"),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: DropDownMultiSelect(
                          onChanged: (List<String> x) {
                            setState(() {
                              moodsSelected = x;
                            });
                          },
                          options: [
                            "Anxious",
                            "Sad",
                            "Nervous",
                            "Happy",
                            "Excited",
                            "Giddy",
                            "Lonely",
                            "Surrounded",
                            "Stressed",
                            "Unfulfilled",
                            "Fulfilled"
                          ],
                          selectedValues: moodsSelected,
                          whenEmpty: "",
                        ))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SimpleFlatButton(
                      text: "Cancel",
                      inputFunc: () {
                        Navigator.pop(context);
                      }),
                  SimpleFlatButton(
                      text: "Done",
                      inputFunc: () {
                        String inputString = selected.toString() + "\n";
                        for (var i = 0; i < activitySelected.length; i++) {
                          inputString += activitySelected[i] + ", ";
                        }
                        inputString += "\n";
                        for (var i = 0; i < moodsSelected.length; i++) {
                          inputString += moodsSelected[i] + ", ";
                        }
                        inputString += "\n" + journalEntry;
                        Future<String> returnstr = sendStringtoFirebase(inputString);


                        final mysnack = SnackBar(
                          content: const Text("Added Entry to your Journal",
                              style: TextStyle(fontSize: 16)),
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(mysnack);
                      }),
                ],
              )
            ]),
          )
        ],
      ),
    );
    ;
  }
}

class EmojiButton extends StatelessWidget {
  const EmojiButton(
      {Key? key,
      required this.text,
      required this.isSelected,
      required this.func})
      : super(key: key);

  final String text;
  final bool isSelected;
  final Function func;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextButton(
          onPressed: () {
            func();
          },
          child: SizedBox(
            height: 60,
            width: 60,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: isSelected ? Color(0x1AB786E5) : Colors.transparent,
                ),
                child: Center(
                    child: Text("$text", style: TextStyle(fontSize: 24)))),
          )),
    );
  }
}

class JournalQuestion extends StatelessWidget {
  final String text;

  const JournalQuestion({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: GoogleFonts.redHatDisplay(),
      textAlign: TextAlign.start,
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
          style: GoogleFonts.redHatDisplay(textStyle: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
