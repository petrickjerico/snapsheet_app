import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapsheetapp/models/parser.dart';
import 'package:snapsheetapp/models/user_data.dart';

class Scanner {
  Parser parser = Parser();

  final UserData userData;

  Scanner(this.userData);

  final textRecognizer = FirebaseVision.instance.textRecognizer();
  File imageFile;
  ImagePicker _picker = ImagePicker();
  FirebaseVisionImage image;
  VisionText visionText;

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

  Future<void> bulkProcess(List<Asset> images, int accId) async {
    final directory = await getApplicationDocumentsDirectory();
    String path;
    for (Asset asset in images) {
      userData.newRecord();
      userData.changeAccount(accId);
      ByteData byteData = await asset.getByteData();
      path = '${directory.path}/${UserData.imageCounter++}';
      final buffer = byteData.buffer;
      imageFile = await File(path).writeAsBytes(
          buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      await process();
      userData.addRecord();
    }
  }

  Future<void> process() async {
    userData.toggleScanned();
    image = FirebaseVisionImage.fromFile(imageFile);
    visionText = await textRecognizer.processImage(image);

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
    value = num.parse(parser.findCost(txt.join(" ")).toStringAsFixed(2));
    date = parser.findDate(txt.join(" "));

    print('$value ${date.toString()} $title');
    // Change userdata TempRecord
    userData.changeTitle(title);
    userData.changeCategory(catId);
    userData.changeValue(value);
    userData.changeDate(date);
    userData.changeImage(imageFile);
  }

  void clearResource() {
    textRecognizer.close();
  }
}
