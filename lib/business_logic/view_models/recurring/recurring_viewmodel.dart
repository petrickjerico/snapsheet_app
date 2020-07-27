import 'package:flutter/material.dart';
import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/recurring/recurring_basemodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';

class RecurringViewModel extends ChangeNotifier implements RecurringBaseModel {
  UserData userData;
  List<Recurring> recurrings;
  List<Account> accounts;
  List<Category> categories;
  Recurring tempRecurring;
  Recurring originalRecurring;
  bool isEditing = false;

  void init(UserData userData) {
    this.userData = userData;
    this.recurrings = userData.recurrings;
    this.accounts = userData.accounts;
    this.categories = userData.categories;
    addDueExpenses();
  }

  Account getAccountFromUid(String accountUid) {
    for (Account account in accounts) {
      if (account.uid == accountUid) {
        return account;
      }
    }
    return accounts.first;
  }

  void addDueExpenses() {
    for (Recurring recurring in recurrings) {
      if (recurring.nextRecurrence.isBefore(DateTime.now())) {
        userData.addRecord(recurring.record);
        recurring.update();
      }
    }
  }

  void undo() {
    tempRecurring = originalRecurring;
    notifyListeners();
  }

  void addRecurring() {
    if (!isEditing) {
      userData.addRecurring(tempRecurring);
    } else {
      userData.updateRecurring(tempRecurring);
      isEditing = false;
    }
    notifyListeners();
  }

  void newRecurring() {
    tempRecurring = Recurring.newBlank();
    tempRecurring.categoryUid = categories.first.uid;
    tempRecurring.accountUid = accounts.first.uid;
    notifyListeners();
  }

  void editTempRecurring(int recurringIndex) {
    tempRecurring = userData.recurrings[recurringIndex];
    originalRecurring = Recurring.of(tempRecurring);
    isEditing = true;
    print(tempRecurring);
    notifyListeners();
  }

  void changeTitle(String newTitle) {
    tempRecurring.title = newTitle;
  }

  void changeValue(double newValue) {
    tempRecurring.value = newValue;
  }

  void changeCategory(int newCategoryId) {
    if (newCategoryId == INCOME) tempRecurring.isIncome = true;
    tempRecurring.categoryUid = userData.categories[newCategoryId].uid;
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

  void changeFrequencyId(int newFrequencyId) {
    tempRecurring.frequencyId = newFrequencyId;
    notifyListeners();
  }

  void changeTimeFrameId(int newTimeFrameId) {
    tempRecurring.timeFrameId = newTimeFrameId;
    notifyListeners();
  }

  void changeInterval(int newInterval) {
    tempRecurring.interval = newInterval;
    notifyListeners();
  }

  void changeUntilDate(DateTime newUntilDate) {
    tempRecurring.untilDate = newUntilDate;
    notifyListeners();
  }

  void changeXTimes(int newXTimes) {
    tempRecurring.xTimes = newXTimes;
    notifyListeners();
  }

  void deleteRecurring() {
    if (isEditing) {
      userData.deleteRecurring(tempRecurring);
      isEditing = false;
    }
    notifyListeners();
  }
}
