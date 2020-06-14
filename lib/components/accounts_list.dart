import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/models/scanner.dart';
import 'package:snapsheetapp/models/user_data.dart';

class AccountsList extends StatefulWidget {
  @override
  _AccountsListState createState() => _AccountsListState();
}

class _AccountsListState extends State<AccountsList> {
  List<Asset> images = List<Asset>();
  bool showSpinner = false;

  Future<void> loadAssets() async {
    images = List<Asset>();

    List<Asset> resultList;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
      );
    } on Exception catch (e) {
      print(e.toString());
    }

    images = resultList;
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
                Text('${images.length} expenses added to $accTitle'),
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
                    if (images != null) {
                      setState(() {
                        showSpinner = true;
                      });
                      Scanner scanner = Scanner(userData);
                      await scanner.bulkProcess(images, index);
                      scanner.clearResource();
                      setState(() {
                        showSpinner = false;
                      });
                      _showMyDialog(context, account.title);
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
