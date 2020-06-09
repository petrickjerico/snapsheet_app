import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapsheetapp/models/parser.dart';
import 'package:snapsheetapp/models/user_data.dart';

class Scanner {
  Parser parser = Parser();

  final bool isCamera;
  final UserData userData;

  Scanner({@required this.isCamera, this.userData});

  Future<void> process() async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    final File imageFile = File(pickedFile.path);
    final image = FirebaseVisionImage.fromFile(imageFile);
    final textRecognizer = FirebaseVision.instance.textRecognizer();
    final visionText = await textRecognizer.processImage(image);

    List<String> txt = [];

    // Initialize title, value, date
    String title;
    double value;
    DateTime date;

    // Process the Strings from scanner
    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          txt.add(word.text.toLowerCase());
        }
      }
    }

    // Update values
    title = parser.findTitle(txt);
    value = parser.findCost(txt.join(" "));
    date = parser.findDate(txt.join(" "));

    print('$value ${date.toString()} $title');
    // Change userdata TempRecord
    userData.changeTitle(title);
    userData.changeValue(value);
    userData.changeDate(date);
    userData.changeImage(imageFile);

    textRecognizer.close();
  }
}
