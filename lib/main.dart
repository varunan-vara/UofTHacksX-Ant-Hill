import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Widgets/AppBar.dart';
import 'package:flutter/services.dart';
import 'Pages/JournalEntry.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

void main() async {
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom],
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Column(
        children: <Widget>[
          NewAppBar(
            isSettings: true,
            contextData: context,
          ),
          SingleChildScrollView(
            child: Column(children: <Widget>[
              const SubAppBar(text: "Home"),
            ]),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: SizedBox(
          height: 70,
          width: 160,
          child: FloatingActionButton.extended(
            label: Text(
              "New Journal",
              style: GoogleFonts.redHatDisplay(),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => JournalEntry()));
            },
            backgroundColor: Color(0xffB786E5),
            tooltip: 'Increment',
            icon: const Icon(
              Icons.add,
              size: 12,
            ),
          ),
        ),
      ),
    );
  }
}
