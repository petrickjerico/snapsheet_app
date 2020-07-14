import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/recurring/recurring_basemodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';

class RecurringViewModel extends ChangeNotifier implements RecurringBaseModel {
  UserData userData;
  List<Recurring> recurrings;
  List<Account> accounts;
  Recurring tempRecurring;
  Recurring originalRecurring;

  void init(UserData userData) {
    this.userData = userData;
    this.recurrings = userData.recurrings;
    this.accounts = userData.accounts;
    addDueExpenses();
  }

  Account getAccountFromUid(String accountUid) {
    return userData.getThisAccount(accountUid);
  }

  void addDueExpenses() {}

  void newRecurring() {
    tempRecurring = Recurring.newBlank();
    tempRecurring.accountUid = accounts.first.uid;
    notifyListeners();
  }

  void changeTitle(String newTitle) {
    tempRecurring.title = newTitle;
    notifyListeners();
  }

  void changeValue(double newValue) {
    tempRecurring.value = newValue;
    notifyListeners();
  }

  void changeCategory(int newCategoryId) {
    tempRecurring.categoryId = newCategoryId;
    notifyListeners();
  }

  void changeAccount(int newAccountId) {
    tempRecurring.accountUid = userData.accounts[newAccountId].uid;
    notifyListeners();
  }

  void changeNextRecurrence(DateTime newDateTime) {
    tempRecurring.nextRecurrence = newDateTime;
    notifyListeners();
  }

  changeFrequencyId(int newFrequencyId) {
    tempRecurring.frequencyId = newFrequencyId;
    notifyListeners();
  }

  changeTimeFrameId(int newTimeFrameId) {
    tempRecurring.timeFrameId = newTimeFrameId;
    notifyListeners();
  }

  changeInterval(int newInterval) {
    tempRecurring.interval = newInterval;
    notifyListeners();
  }

  changeUntilDate(DateTime newUntilDate) {
    tempRecurring.untilDate = newUntilDate;
    notifyListeners();
  }

  changeXTimes(int newXTimes) {
    tempRecurring.xTimes = newXTimes;
    notifyListeners();
  }
}
