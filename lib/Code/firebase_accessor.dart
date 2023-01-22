import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'dart:io';

final storage =
    FirebaseStorage.instanceFor(bucket: "gs://ant-hill-adf22.appspot.com");

Future<String> sendStringtoFirebase(String inputString) async {
  try {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk-mm-ss-EEE-d-MMM').format(now);
    print(formattedDate + "-JournalUpload");
    print(inputString);
    final fileref = storage
        .ref()
        .child("User Data")
        .child(formattedDate + "-JournalUpload.txt");

    Directory tempDir = await getTemporaryDirectory();
    String pathWay = tempDir.path;
    File textFile = File("$pathWay/$formattedDate-JournalUpload.txt");
    await textFile.writeAsString(inputString);
    await fileref.putFile(textFile);
    print("Success");
    return "Added Entry to your Journal";
  } on FirebaseException catch (e) {
    print("Fail");
    print(e);
    return "Error: Network Connection";
  }
}
