import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/export_list.dart';
import 'package:snapsheetapp/components/fading_export_dialog.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'file:///C:/Users/jtedd/AndroidStudioProjects/snapsheet_app/lib/archive/exportdone_screen.dart';

class ExportSelectScreen extends StatelessWidget {
  static const String id = 'exportselect_screen';

  @override
  Widget build(BuildContext context) {
    DateTime start;
    DateTime end;
    return Consumer<UserData>(builder: (context, userData, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: BackButton(),
          title: Text('EXPORT SELECTIONS'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(flex: 7, child: ExportList()),
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
                      'EXPORT',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () async {
                    await userData.exporter.exportCSV();
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
