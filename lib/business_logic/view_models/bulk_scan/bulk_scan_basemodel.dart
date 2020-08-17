import 'package:snapsheetapp/business_logic/view_models/user_data/user_data_impl.dart';

abstract class BulkScanBaseModel {
  void init(UserData userData);
  Future<void> loadAssets();
  Future<void> initialize();
  void addAll();
  void changeValue(int recordId, double newValue);
  void changeTitle(int recordId, String newTitle);
  void changeDate(int recordId, DateTime newDateTime);
  void changeCategory(int recordId, int newCategoryId);
}
