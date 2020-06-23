import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_basemodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';

class ExpenseViewModel extends ChangeNotifier implements ExpenseBaseModel {
  Record tempRecord;
  final UserData userData;

  ExpenseViewModel(this.userData);

  void setTempRecord(Record record) {
    tempRecord = record;
  }

  void changeTitle(String newTitle) {
    tempRecord.title = newTitle;
  }

  void changeValue(double newValue) {
    tempRecord.value = newValue;
  }

  void changeDate(DateTime newDateTime) {
    tempRecord.dateTime = newDateTime;
  }

  void changeCategory(int newCategoryId) {
    tempRecord.categoryId = newCategoryId;
  }

  void changeAccount(int newAccountId) {
    tempRecord.accountId = newAccountId;
  }

  void changeImage(File imageFile) {
    tempRecord.image = imageFile;
  }
}
