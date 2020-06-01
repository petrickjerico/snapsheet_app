import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapsheetapp/components/calculator.dart';
import 'package:snapsheetapp/screens/editinfo_screen.dart';
import 'package:snapsheetapp/screens/scanner_screen.dart';

import 'scanner_screen.dart';
// import 'package:snapsheetapp/screens/homepage_screen.dart';

class AddExpensesScreen extends StatelessWidget {
  static const String id = 'addexpenses_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: FlatButton(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            //TODO: more complex navigation
            Navigator.pop(context);
          },
        ),
        title: Text('ADD EXPENSES'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, EditInfoScreen.id);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
            onPressed: () async {
              final imageFile = await ImagePicker.pickImage(
                source: ImageSource.camera,
              );
              final image = FirebaseVisionImage.fromFile(imageFile);
              final textRecognizer = FirebaseVision.instance.textRecognizer();
              final visionText = await textRecognizer.processImage(image);
              for (TextBlock block in visionText.blocks) {
                for (TextLine line in block.lines) {
                  for (TextElement word in line.elements) {
                    print(word.text);
                  }
                }
                textRecognizer.close();
              }
            },
          ),
        ],
      ),
      body: Calculator(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.check),
        onPressed: () {
          //TODO: more complex navigation
          Navigator.pop(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 30.0,
          child: Container(
            child: null,
          ),
        ),
      ),
    );
  }
}
