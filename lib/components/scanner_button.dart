import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:snapsheetapp/screens/addexpenses_screen.dart';
import 'parser.dart';

class ScannerButton extends StatelessWidget {
  final bool isCamera;

  ScannerButton({@required this.isCamera});

  Parser parser = Parser();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userData, child) {
        return IconButton(
          icon: Icon(
            isCamera ? Icons.camera_alt : Icons.photo_library,
            color: Colors.white,
          ),
          onPressed: () async {
            // Setup
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

            textRecognizer.close();
            Navigator.pop(context);
            Navigator.pushNamed((context), AddExpensesScreen.id);
          },
        );
      },
    );
  }
}
