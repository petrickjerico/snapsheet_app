import 'dart:io';

import 'package:snapsheetapp/business_logic/models/models.dart';

abstract class ExpenseBaseModel {
  void setTempRecord(Record record);
  void changeTitle(String newTitle);
  void changeValue(double newValue);
  void changeDate(DateTime newDateTime);
  void changeCategory(int newCategoryId);
  void changeAccount(int newAccountId);
  void changeImage(File imageFile);
}
