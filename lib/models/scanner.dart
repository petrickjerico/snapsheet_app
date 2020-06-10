import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapsheetapp/models/parser.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:snapsheetapp/screens/addexpenses_screen.dart';

class Scanner {
  Parser parser = Parser();

  final UserData userData;
  final String screenId;

  Scanner({this.userData, this.screenId});

  File imageFile;
  ImagePicker _picker = ImagePicker();

  _openGallery(BuildContext context) async {
    var picture = await _picker.getImage(source: ImageSource.gallery);
    imageFile = File(picture.path);
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await _picker.getImage(source: ImageSource.camera);
    imageFile = File(picture.path);
    Navigator.of(context).pop();
  }

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Select"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> process(BuildContext context) async {
    await showChoiceDialog(context);
    final textRecognizer = FirebaseVision.instance.textRecognizer();
    final image = FirebaseVisionImage.fromFile(imageFile);
    final visionText = await textRecognizer.processImage(image);

    List<String> txt = [];

    // Initialize title, value, date
    String title;
    int catId;
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
    catId = parser.findCategoryId();
    value = parser.findCost(txt.join(" "));
    date = parser.findDate(txt.join(" "));

    print('$value ${date.toString()} $title');
    // Change userdata TempRecord
    userData.changeTitle(title);
    userData.changeCategory(catId);
    userData.changeValue(value);
    userData.changeDate(date);
    userData.changeImage(imageFile);

    textRecognizer.close();
    Navigator.of(context).pop();
    Navigator.pushNamed(context, screenId);
  }
}
