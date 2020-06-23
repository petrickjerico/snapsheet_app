import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:snapsheetapp/services/parser/parser_impl.dart';
import 'package:snapsheetapp/services/scanner/scanner.dart';

class ScannerImpl implements Scanner {
  final textRecognizer = FirebaseVision.instance.textRecognizer();
  final parser = ParserImpl();

  Future<List<String>> txtListFromImage(File imageFile) async {
    FirebaseVisionImage image = FirebaseVisionImage.fromFile(imageFile);
    VisionText visionText = await textRecognizer.processImage(image);

    List<String> txt = [];

    // Process the Strings from scanner
    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          txt.add(word.text.toLowerCase());
        }
      }
    }
    return txt;
  }

  Map<String, dynamic> extractDataFromTxt(List<String> txt) {
    Map<String, dynamic> map = {
      'title': "",
      'catId': 0,
      'value': 0,
      'date': DateTime.now()
    };

    String title = parser.findTitle(txt);
    int catId = parser.findCategoryId();
    double value = parser.findCost(txt.join(" "));
    DateTime date = parser.findDate(txt.join(" "));

    print('${value} ${date.toString()} ${title}');

    map['title'] = title;
    map['catId'] = catId;
    map['value'] = value;
    map['date'] = date;

    return map;
  }

  void clearResources() {
    textRecognizer.close();
  }

}