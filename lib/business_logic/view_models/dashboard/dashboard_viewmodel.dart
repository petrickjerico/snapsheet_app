import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/dashboard_basemodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';

class DashboardViewModel extends ChangeNotifier implements DashboardBaseModel {
  UserData userData;
  List<Account> accounts;
  List<Record> records;
  List<bool> isSelected = [];
  int selectedAccountIndex = -1;
  int touchedIndex;
  Account originalAccount;
  Account tempAccount;

  void init(UserData userData) {
    this.userData = userData;
    accounts = userData.accounts;
    records = userData.records;
    isSelected = List.generate(accounts.length, (_) => true);
  }

  void initEditAccount(int accountIndex) {
    originalAccount = accounts[accountIndex];
    tempAccount = Account.of(originalAccount);
  }

  String getSelectedAccountUid() {
    if (selectedAccountIndex != -1) return accounts[selectedAccountIndex].uid;
  }

  Account getSelectedAccount() {
    if (selectedAccountIndex != -1) return accounts[selectedAccountIndex];
  }

  void addAccount(String title, Color color) {
    userData.addAccount(
        Account(title: title, color: color, index: accounts.length));
    notifyListeners();
  }

  void updateAccount() {
    originalAccount.title = tempAccount.title;
    originalAccount.color = tempAccount.color;
    userData.updateAccount(originalAccount);
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
    touchedIndex = null;
    if (newIndex == -1) isSelected.forEach((element) => element = true);
    notifyListeners();
  }

  ///

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

  void updateTouchedIndex(int i) {
    print('touched $i');
    if (touchedIndex == i) {
      touchedIndex = null;
    } else {
      touchedIndex = i;
    }
  }

  List<PieChartSectionData> showingCategorySections() {
    return List.generate(
      categories.length,
      (i) {
        final Category category = categories[i];
        final bool isTouched = i == touchedIndex;
        final bool isIncome = category.isIncome;
        final double opacity = isTouched ? 1 : 0.4;
        final value = getCategoryTotal(i);
        switch (i) {
          default:
            return PieChartSectionData(
              color: category.color.withOpacity(opacity),
              value: isIncome ? 0 : value,
              showTitle: isTouched && value > 0 && !isIncome,
              title: '${category.title} \n ${value.toStringAsFixed(2)}',
              radius: isTouched ? 40 : 30,
              titleStyle:
                  TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.8)),
              titlePositionPercentageOffset: -1.5,
            );
        }
      },
    );
  }

  bool selectedAccountIsEmpty() {
    bool res =
        !records.any((rec) => rec.accountUid == getSelectedAccountUid()) &&
            selectedAccountIndex != -1;

    return res;
  }

  bool selectedAccountHasIncome() {
    return records.any(
        (rec) => rec.accountUid == getSelectedAccountUid() && rec.isIncome);
  }

  bool recordMatchesStats(Record rec) {
    return (selectedAccountIndex == -1 ||
        rec.accountUid == accounts[selectedAccountIndex].uid);
  }

  double getCategoryTotal(int catId) {
    if (categories[catId].isIncome) {
      return 0;
    } else {
      double total = 0;
      for (Record rec in records) {
        if (recordMatchesStats(rec) && rec.categoryId == catId) {
          total += rec.value;
        }
      }
      return num.parse(total.toStringAsFixed(2));
    }
  }

  double currentExpensesTotal() {
    double total = 0;
    for (Record rec in records) {
      if (!rec.isIncome && recordMatchesStats(rec)) {
        total += rec.value;
      }
    }
    return num.parse(total.toStringAsFixed(2));
  }

  List<double> statsGetBalanceData() {
    double incomeSum = selectedAccountHasIncome()
        ? records
            .where((rec) =>
                rec.isIncome && rec.accountUid == getSelectedAccountUid())
            .map((rec) => rec.value)
            .reduce((value, element) => value + element)
        : 0;

    double expenseSum = currentExpensesTotal();
    double balanceSum = incomeSum - expenseSum;
    double incomePercent = incomeSum * 100 / (incomeSum + expenseSum);
    double expensePercent = expenseSum * 100 / (incomeSum + expenseSum);

    return [incomeSum, expenseSum, balanceSum, incomePercent, expensePercent];
  }

  List<Record> getTop5Records() {
    List<Record> res = [];

    for (Record rec in records) {
      if (res.length == 5) {
        break;
      }
      if (recordMatchesStats(rec)) {
        res.add(rec);
      }
    }

    return res;
  }
}
