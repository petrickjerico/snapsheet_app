import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/export_list.dart';
import 'package:snapsheetapp/models/user_data.dart';

class ExportSelectScreen extends StatelessWidget {
  static const String id = 'exportselect_screen';

  Future<void> _showMyDialog(context) async {
    String dir = (await DownloadsPathProvider.downloadsDirectory).path;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Export Done'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('File is in $dir'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
                      'EXPORT CSV',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () async {
                    await userData.exporter.exportCSV();
                    _showMyDialog(context);
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
