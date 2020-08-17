import 'package:flutter/material.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data/user_data_impl.dart';

abstract class ExpenseBaseModel {
  /// Initialize the model with UserData.
  void init(UserData userData);

  /// Capture data from image captured / selected.
  Future<void> imageToTempRecord();

  /// Index in the list of accounts.
  int getAccountIndexFromTempRecord();

  /// Calculator??
  //TODO
  void toggleScanned();
  void toggleOperated(bool isOperated);
  void setExpression(String expression);

  /// Initialize a new record.
  void newRecord();

  /// Initialization for editing the selected record.
  void changeTempRecord(int recordIndex);

  /// Add the new record / Update the selected record.
  void addRecord();

  /// Show Camera or Gallery option to get the receipt image.
  Future<void> showChoiceDialog(BuildContext context);

  /// Discard all the edits that have been made
  void undoEditRecord();

  /// Update the new/selected record's attribute with the new value.
  void changeTitle(String newTitle);
  void changeValue(double newValue);
  void changeDate(DateTime newDateTime);
  void changeCategory(int newCategoryId);
  void changeAccount(int newAccountIndex);
  void changeImage(String imagePath);

  /// Deletion of image and record.
  void deleteImage();
  void deleteRecord();

  /// To check whether the selected record has an image.
  bool hasImage();

  /// Export the image through third party app.
  Future<void> exportImage();
}
