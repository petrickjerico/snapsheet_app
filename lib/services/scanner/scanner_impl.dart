import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:snapsheetapp/services/parser/parser_impl.dart';
import 'package:snapsheetapp/services/scanner/scanner.dart';
export 'scanner.dart';

class ScannerImpl implements Scanner {
  final textRecognizer = FirebaseVision.instance.textRecognizer();
  final parser = ParserImpl();

  Future<Map<String, dynamic>> getDataFromImage(File imageFile) async {
    List<String> txt = await _txtListFromImage(imageFile);
    Map<String, dynamic> map = _extractDataFromTxt(txt);
    map['image'] = imageFile;
    return map;
  }

  Future<List<String>> _txtListFromImage(File imageFile) async {
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

  Map<String, dynamic> _extractDataFromTxt(List<String> txt) {
    Map<String, dynamic> map = {
      'title': "",
      'categoryId': 0,
      'value': 0,
      'dateTime': DateTime.now()
    };

    String title = parser.findTitle(txt);
    int catId = parser.findCategoryId();
    double value = parser.findCost(txt.join(" "));
    DateTime date = parser.findDate(txt.join(" "));

    print('${value} ${date.toString()} ${title}');

    map['title'] = title;
    map['categoryId'] = catId;
    map['value'] = value;
    map['dateTime'] = date;

    return map;
  }

  void clearResources() {
    textRecognizer.close();
  }
}
