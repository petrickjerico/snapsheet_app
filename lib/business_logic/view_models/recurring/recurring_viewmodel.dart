import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/recurring/recurring_basemodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';

class RecurringViewModel extends ChangeNotifier implements RecurringBaseModel {
  UserData userData;
  List<Recurring> recurrings;
  Recurring tempRecurring;
  Recurring originalRecurring;

  init(UserData userData) {
    this.userData = userData;
    this.recurrings = userData.recurrings;
    addDueExpenses();
  }

  addDueExpenses() {}

  changeTitle(String newTitle) {
    tempRecurring.title = newTitle;
    notifyListeners();
  }

  changeValue(double newValue) {
    tempRecurring.value = newValue;
    notifyListeners();
  }

  changeCategory(int newCategoryId) {
    tempRecurring.categoryId = newCategoryId;
    notifyListeners();
  }

  changeAccount(int newAccountId) {
    tempRecurring.accountUid = userData.accounts[newAccountId].uid;
    notifyListeners();
  }

  changeNextRecurrence(DateTime newDateTime) {
    tempRecurring.nextRecurrence = newDateTime;
    notifyListeners();
  }
}
