import 'package:flutter/cupertino.dart';
import 'package:snapsheetapp/business_logic/view_models/bulk_scan/bulk_scan_basemodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';

class BulkScanViewModel extends ChangeNotifier implements BulkScanBaseModel {
  final UserData userData;

  BulkScanViewModel({this.userData});
}
