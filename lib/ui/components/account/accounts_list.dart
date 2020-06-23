import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/models/record_preview.dart';
import 'package:snapsheetapp/models/user.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:snapsheetapp/screens/sidebar/receipt_preview.dart';
import 'package:snapsheetapp/services/scanner.dart';

class AccountsList extends StatefulWidget {
  @override
  _AccountsListState createState() => _AccountsListState();
}

class _AccountsListState extends State<AccountsList> {
  List<Asset> assets = List<Asset>();
  bool showSpinner = false;

  Future<void> loadAssets() async {
    assets = List<Asset>();

    List<Asset> resultList;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
      );
    } on Exception catch (e) {
      print(e.toString());
    }

    assets = resultList;
  }

  Future<void> _showMyDialog(context, String accTitle) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bulk Scan is done'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('${assets.length} expenses added to $accTitle'),
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
    return Consumer<UserData>(
      builder: (context, userData, child) {
        return ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: ListView.separated(
            padding: EdgeInsets.all(12),
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final account = userData.accounts[index];
              return Container(
                color: account.color,
                child: ListTile(
                  title: Text(
                    account.title,
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    await loadAssets();
                    if (assets != null) {
                      setState(() {
                        showSpinner = true;
                      });
                      RecordView recordView = RecordView(
                          id: index, assets: assets, userData: userData);
                      print('recordView');
                      await recordView.initialize();
                      print('INITIALIZED');
                      setState(() {
                        showSpinner = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReceiptPreview(
                                    recordView: recordView,
                                  )));
                    }
                  },
                ),
              );
            },
            itemCount: userData.accounts.length,
          ),
        );
      },
    );
  }
}
