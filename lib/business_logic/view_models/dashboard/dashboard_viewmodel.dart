import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/dashboard_basemodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';

class DashboardViewModel extends ChangeNotifier implements DashboardBaseModel {
  final UserData userData;
  List<Account> accounts;
  List<Record> records;
  List<bool> isSelected;
  int selectedAccountIndex;

  DashboardViewModel({this.userData}) {
    accounts = userData.accounts;
    records = userData.records;
    isSelected = List.generate(accounts.length, (_) => true);
  }

  void addAccount(String title, Color color) {
    userData.addAccount(
        Account(title: title, color: color, index: accounts.length));
    notifyListeners();
  }

  void updateAccount(String newTitle, Color newColor) {
    Account target = accounts[selectedAccountIndex];
    target.title = newTitle;
    target.color = newColor;
    userData.updateAccount(target);
    notifyListeners();
  }

  void deleteAccount() {
    Account target = accounts[selectedAccountIndex];
    accounts.remove(target);
    isSelected.removeAt(selectedAccountIndex);
    for (Record record in records) {
      if (record.accountUid == target.uid) {
        userData.deleteRecord(record);
      }
    }
    selectedAccountIndex--;
    for (Account account in accounts) {
      if (account.index > selectedAccountIndex) {
        account.index--;
        userData.updateAccount(account);
      }
    }
    notifyListeners();
  }

  void selectAccount(int newIndex) {
    selectedAccountIndex = newIndex;
    notifyListeners();
  }

  double getSumFromAccount(Account acc) {
    String uid = acc.uid;
    double sum = 0;

    for (Record record in records) {
      if (record.accountUid != uid) continue;
      if (record.isIncome) {
        sum += record.value;
      } else {
        sum -= record.value;
      }
    }

    return sum;
  }
}
