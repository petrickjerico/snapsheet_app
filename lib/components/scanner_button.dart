import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'parser.dart';

class ScannerButton extends StatelessWidget {
  final bool isCamera;

  ScannerButton({@required this.isCamera});

  Parser parser = Parser();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isCamera ? Icons.camera_alt : Icons.photo_library,
        color: Colors.white,
      ),
      onPressed: () async {
        final _picker = ImagePicker();
        final pickedFile = await _picker.getImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery,
        );
        final File imageFile = File(pickedFile.path);
        final image = FirebaseVisionImage.fromFile(imageFile);
        final textRecognizer = FirebaseVision.instance.textRecognizer();
        final visionText = await textRecognizer.processImage(image);
        List<String> txt = [];
        for (TextBlock block in visionText.blocks) {
          for (TextLine line in block.lines) {
            for (TextElement word in line.elements) {
              txt.add(word.text.toLowerCase());
            }
          }
        }
        print(txt.join(' '));
        print(parser.findDate(txt.join(' ')).toString());
        textRecognizer.close();
      },
    );
  }
}
