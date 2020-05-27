import 'package:flutter/material.dart';
import 'package:snapsheetapp/screens/homepage_screen.dart';

class CalculatorScreen extends StatelessWidget {
  static const String id = 'calculator_screen';
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
            Navigator.pushNamed(context, HomepageScreen.id);
          },
        ),
        title: Text('CALCULATOR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera_alt),
            color: Colors.white,
            onPressed: () {
              // nothing yet
            },
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Text(
            'Calculator will go here.',
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.check),
        onPressed: () {
          // nothing yet
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: CircularNotchedRectangle(),
        child: Container(
            height: 50.0,
            child: Container(
              child: Row(
                children: <Widget>[],
              ),
            )),
      ),
    );
  }
}
