import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/welcome_screen.dart';
import 'package:flutter_application/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AntHill',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}

class JournalPage extends StatefulWidget {
  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  final List<String> _entries = <String>[];
  final TextEditingController _controller = TextEditingController();

  void _addEntry() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        _entries.add(_controller.text);
        _controller.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AntHill')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              key: UniqueKey(),
              padding: const EdgeInsets.all(8),
              itemCount: _entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Text(_entries[index]),
                );
              },
            ),
          ),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter a new entry',
            ),
            onSubmitted: (String value) {
              _addEntry();
            },
          ),
        ],
      ),
    );
  }
}
