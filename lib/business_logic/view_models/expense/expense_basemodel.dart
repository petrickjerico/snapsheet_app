import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';

abstract class ExpenseBaseModel {
  void toggleScanned();
  void addRecord();
  Future<void> showChoiceDialog(BuildContext context);
  Future imageToTempRecord();
  void newTempRecord(Record record);
  void changeTitle(String newTitle);
  void changeValue(double newValue);
  void changeDate(DateTime newDateTime);
  void changeCategory(int newCategoryId);
  void changeAccount(int newAccountId);
  void changeImage(File imageFile);
}
