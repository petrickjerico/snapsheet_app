import 'package:snapsheetapp/business_logic/view_models/user_data/user_data_impl.dart';

abstract class BulkScanBaseModel {
  /// Initialize the model with UserData.
  void init(UserData userData);

  /// Loads the image receipts that the user has chosen.
  Future<void> loadAssets();

  /// Process the loaded image receipts into Records.
  Future<void> processImages();

  /// Add all confirmed receipts.
  void addConfirmedReceipts();

  /// Update a particular receipt's attribute with the new value.
  /// The first argument recordId refers to a particular receipt.
  void changeValue(int recordId, double newValue);
  void changeTitle(int recordId, String newTitle);
  void changeDate(int recordId, DateTime newDateTime);
  void changeCategory(int recordId, int newCategoryId);
}
