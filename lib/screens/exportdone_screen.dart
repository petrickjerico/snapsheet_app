import 'package:flutter/material.dart';
import 'package:snapsheetapp/screens/homepage_screen.dart';

class ExportDoneScreen extends StatelessWidget {
  static const String id = 'exportdone_screen';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('EXPORT DONE'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 7,
              child: Container(
                child: Center(
                  child: Text(
                    'Screen will indicate "export done".',
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
                      Icons.check,
                      color: Colors.white,
                    ),
                    title: Text(
                      'RETURN TO HOMEPAGE',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () {
                    // TODO: implement export functionality
                    Navigator.pushNamed(context, HomepageScreen.id);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
