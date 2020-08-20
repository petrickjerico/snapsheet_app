import 'package:flutter/material.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/recurring/recurring_basemodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data/user_data_impl.dart';

class RecurringViewModel extends ChangeNotifier implements RecurringBaseModel {
  UserData userData;
  List<Recurring> recurrings;
  List<Account> accounts;
  List<Category> categories;
  Recurring tempRecurring;
  Recurring originalRecurring;
  bool isEditing = false;

  /// Initialize the model with UserData.
  void init(UserData userData) {
    this.userData = userData;
    this.recurrings = userData.recurrings;
    this.accounts = userData.accounts;
    this.categories = userData.categories;
    userData.addDueExpenses();
  }

  /// Helper function to get account from userData since Recurring only
  /// contains the account uid.
  Account getAccountFromUid(String accountUid) {
    for (Account account in accounts) {
      if (account.uid == accountUid) {
        return account;
      }
    }
    return accounts.first;
  }

  /// Disard all the edits that have been made.
  void undo() {
    tempRecurring = originalRecurring;
    notifyListeners();
  }

  /// Initialize a new recurring record.
  void newRecurring() {
    tempRecurring = Recurring.newBlank();
    tempRecurring.categoryUid = categories.first.uid;
    tempRecurring.accountUid = accounts.first.uid;
    notifyListeners();
  }

  /// Initialization for editing the selected recurring record.
  void editTempRecurring(int recurringIndex) {
    tempRecurring = userData.recurrings[recurringIndex];
    originalRecurring = Recurring.of(tempRecurring);
    isEditing = true;
    notifyListeners();
  }

  /// Add the new recurring record / Update the selected recurring record.
  void addRecurring() {
    if (!isEditing) {
      userData.addRecurring(tempRecurring);
    } else {
      userData.updateRecurring(tempRecurring);
      isEditing = false;
    }
    notifyListeners();
  }

  /// Update the new/selected record's attribute with the new value.
  void changeTitle(String newTitle) {
    tempRecurring.title = newTitle;
  }

  void changeValue(double newValue) {
    tempRecurring.value = newValue;
  }

  void changeCategory(int newCategoryId) {
    tempRecurring.isIncome = userData.categories[newCategoryId].isIncome;
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

  /// Deletion.
  void deleteRecurring() {
    if (isEditing) {
      userData.deleteRecurring(tempRecurring);
      isEditing = false;
    }
    notifyListeners();
  }
}
