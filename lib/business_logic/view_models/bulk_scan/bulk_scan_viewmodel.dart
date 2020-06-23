import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/bulk_scan/bulk_scan_basemodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';

class BulkScanViewModel extends ChangeNotifier implements BulkScanBaseModel {
  final UserData userData;
  List<Asset> assets = List<Asset>();
  List<Account> accounts;

  BulkScanViewModel({this.userData}) {
    accounts = userData.accounts;
  }

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
}
