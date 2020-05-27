import 'package:flutter/material.dart';
import 'package:snapsheetapp/screens/exportdone_screen.dart';
import 'package:snapsheetapp/screens/homepage_screen.dart';

class ExportSelectScreen extends StatelessWidget {
  static const String id = 'exportselect_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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
        title: Text('EXPORT SELECTIONS'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Container(
              child: Center(
                child: Text(
                  'Export parameter selections will go here.',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                color: Colors.black,
              ),
              margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
              child: FlatButton(
                child: ListTile(
                  leading: Icon(
                    Icons.file_upload,
                    color: Colors.white,
                  ),
                  title: Text(
                    'PROCEED TO EXPORT',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // TODO: implement export functionality
                    Navigator.pushNamed(context, ExportDoneScreen.id);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
