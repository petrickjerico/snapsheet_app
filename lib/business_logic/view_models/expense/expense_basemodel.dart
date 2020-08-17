import 'package:flutter/material.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data/user_data_impl.dart';

abstract class ExpenseBaseModel {
  void init(UserData userData);
  Future<void> imageToTempRecord();
  int getAccountIndexFromTempRecord();
  int getCategoryIndexFromTempRecord();
  void toggleScanned();
  void toggleOperated(bool isOperated);
  void setExpression(String expression);
  void addRecord();
  Future<void> showChoiceDialog(BuildContext context);
  void newRecord();
  void changeTempRecord(int recordIndex);
  void undoEditRecord();
  void changeTitle(String newTitle);
  void changeValue(double newValue);
  void changeDate(DateTime newDateTime);
  void changeCategory(int newCategoryId);
  void changeAccount(int newAccountIndex);
  void changeImage(String imagePath);
  void deleteImage();
  void deleteRecord();
  bool hasImage();
  Future<void> exportImage();
}
