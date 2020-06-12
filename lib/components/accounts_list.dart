import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/models/user_data.dart';

class AccountsList extends StatefulWidget {
  @override
  _AccountsListState createState() => _AccountsListState();
}

class _AccountsListState extends State<AccountsList> {
  List<Asset> images = List<Asset>();

  Widget buildGridView() {
    if (images != null)
      return GridView.count(
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }),
      );
    else
      return Container(color: Colors.white);
  }

  Future<void> loadAssets() async {
    images = List<Asset>();

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userData, child) {
        return ListView.separated(
          padding: EdgeInsets.all(12),
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
//            final account = exporter.accounts[index];
//            final isExport = exporter.isExport[index];
//            return ExportTile(
//              account: account,
//              isExport: isExport,
//              voidCallback: () {
//                userData.toggleExport(index);
//                print(exporter.isExport.toString());
//              },
//            );
          },
          itemCount: 10,
        );
      },
    );
  }

  Widget _getListItemTile(BuildContext context, int index) {}
}
