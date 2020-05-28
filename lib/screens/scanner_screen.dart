import 'package:flutter/material.dart';

import 'editinfo_screen.dart';

class ScannerScreen extends StatelessWidget {
  static const String id = 'scanner_screen';

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
        title: Text('SCAN RECEIPT'),
      ),
      body: Center(
        child: Text(
          'User scans a receipt here.\n\n'
          'After scanning, User is brought to Edit Information\n'
          'to confirm scanned info',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.camera_alt),
        onPressed: () {
          //TODO: more complex navigation
          Navigator.pushNamed(context, EditInfoScreen.id);
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
