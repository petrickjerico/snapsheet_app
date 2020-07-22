import 'package:carousel_slider/carousel_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';

import 'homepage_basemodel.dart';

class HomepageViewModel extends ChangeNotifier implements HomepageBaseModel {
  static final CarouselController controller = CarouselController();
  static int currentPage = 0;
  static int currentBar = 0;
  static int selectedAccountIndex = 0;
  UserData userData;
  List<Account> accounts;
  List<Record> records;
  List<bool> isSelected = [];
  int donutTouchedIndex;
  Account originalAccount;
  Account tempAccount;
  bool balanceCustom = true;
  bool expenseBreakdownCustom = true;
  bool amountTrendCustom = true;

  // List<Account> get copyOfAccounts => List.from(accounts);

  void syncBarToPage(int index) {
    currentBar = index;
    if (index == 2) {
      return;
    } else if (index > 2) {
      currentPage = index - 1;
    } else {
      currentPage = index;
    }
    notifyListeners();
  }

  static void syncBarAndTabToBeginning() {
    currentPage = 0;
    currentBar = 0;
  }

  static void syncController() {
    if (selectedAccountIndex != -1) {
      controller.animateToPage(selectedAccountIndex);
    } else {
      controller.animateToPage(0);
    }
  }

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
    return selectedAccountIndex != -1
        ? accounts[selectedAccountIndex].uid
        : null;
  }

  Account getSelectedAccount() {
    return selectedAccountIndex != -1 ? accounts[selectedAccountIndex] : null;
  }

  List<Account> getAccounts() {
    return selectedAccountIndex == -1
        ? accounts
        : accounts
            .where((account) =>
                selectedAccountIndex == -1 ||
                account.index == selectedAccountIndex)
            .toList();
  }

  void addAccount(String title, Color color) {
    userData.addAccount(
        Account(title: title, color: color, index: accounts.length));
    isSelected.add(false);
    notifyListeners();
  }

  void updateAccount() {
    originalAccount.title = tempAccount.title;
    originalAccount.color = tempAccount.color;
    userData.updateAccount(originalAccount);
    notifyListeners();
  }

  void deleteAccount() {
    Account target = getSelectedAccount();
    userData.deleteAccount(target);
    isSelected.removeAt(selectedAccountIndex);
    List<Record> newRecords = List.from(records);
    for (Record record in newRecords) {
      if (record.accountUid == target.uid) {
        userData.deleteRecord(record);
      }
    }
    List<Recurring> newRecurrings = List.from(userData.recurrings);
    for (Recurring recurring in newRecurrings) {
      if (recurring.accountUid == target.uid) {
        userData.deleteRecurring(recurring);
      }
    }
    records = userData.records;
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
    donutTouchedIndex = null;
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

  void updateDonutTouchedIndex(int i) {
    if (donutTouchedIndex == i) {
      donutTouchedIndex = null;
    } else {
      donutTouchedIndex = i;
    }
  }

  List<PieChartSectionData> showingCategorySections() {
    return List.generate(
      userData.categories.length,
      (i) {
        final Category category = userData.categories[i];
        final bool isTouched = i == donutTouchedIndex;
        final bool isIncome = category.isIncome;
        final double opacity = isTouched ? 1 : 0.6;
        final value = getCategoryTotal(i);
        switch (i) {
          default:
            return PieChartSectionData(
              color: category.color.withOpacity(opacity),
              value: isIncome ? 0 : value,
              showTitle: isTouched && value > 0 && !isIncome,
              title: '${category.title} \n ${value.toStringAsFixed(2)}',
              radius: isTouched ? 40 : 30,
              titleStyle: TextStyle(fontSize: 15, color: Colors.white54),
              titlePositionPercentageOffset: -1.5,
            );
        }
      },
    );
  }

  bool selectedAccountIsEmpty() {
    return !records.any((rec) => rec.accountUid == getSelectedAccountUid()) &&
        selectedAccountIndex != -1;
  }

  bool selectedAccountHasIncome() {
    return records.any(
        (rec) => rec.accountUid == getSelectedAccountUid() && rec.isIncome);
  }

  bool selectedAccountHasExpense() {
    return records.any((rec) => recordMatchesStats(rec) && !rec.isIncome);
  }

  bool recordMatchesStats(Record rec) {
    return (selectedAccountIndex == -1 ||
        rec.accountUid == getSelectedAccountUid());
  }

  double getCategoryTotal(int catId) {
    Category category = userData.categories[catId];
    if (category.isIncome) {
      return 0;
    } else {
      double total = 0;
      for (Record rec in records) {
        if (recordMatchesStats(rec) && rec.categoryUid == category.uid) {
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

  List<Record> getRecordsFromCurrentAccount() {
    List<Record> res = [];
    for (Record rec in records) {
      if (recordMatchesStats(rec)) {
        res.add(rec);
      }
    }

    return res;
  }

  List<Record> getTop5Records() {
    List<Record> res = getRecordsFromCurrentAccount();
    return res.take(5).toList();
  }

  bool isAccountSelected(Account acc) {
    return acc.index == selectedAccountIndex;
  }

  ///

  List<MapEntry<double, double>> getXYMapValues() {
    DateTime now = DateTime.now();
    double total = 0;
    List<Record> recs =
        records.where((rec) => recordMatchesStats(rec)).toList();

    Map<double, double> spotsMap = {};

    recs.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    for (Record rec in recs) {
      var val = rec.isIncome ? rec.value : -rec.value;
      var dateDifference = rec.dateTime.difference(now).inDays.toDouble();
      total += val;
      spotsMap.update(
        dateDifference,
        (value) => value + val,
        ifAbsent: () => total,
      );
    }

    var copy = List.of(spotsMap.entries);

    for (int i = 0; i < copy.length; i++) {
      spotsMap.putIfAbsent(
          copy[i].key - 1, () => i == 0 ? 0 : copy[i - 1].value);
    }

    var finalData = spotsMap.entries.toList();

    finalData.sort((a, b) => a.key.compareTo(b.key));
    finalData.add(MapEntry(0, finalData.last.value));

    return finalData;
  }

  List<double> getLimits() {
    var spotsMap = getXYMapValues();
    double minDate;
    double minValue;
    double maxDate;
    double maxValue;
    bool first = true;

    void syncLimits(double xVal, double yVal) {
      if (first) {
        minDate = xVal;
        maxDate = xVal;
        minValue = yVal;
        maxValue = yVal;
        first = false;
      } else {
        if (minDate > xVal) {
          minDate = xVal;
        }

        if (maxDate < xVal) {
          maxDate = xVal;
        }

        if (minValue > yVal) {
          minValue = yVal;
        }

        if (maxValue < yVal) {
          maxValue = yVal;
        }
      }
    }

    for (var entry in spotsMap) {
      syncLimits(entry.key, entry.value);
    }

    return [
      minDate,
      maxDate,
      minValue,
      maxValue,
      (maxDate - minDate).roundToDouble() / 4,
      (maxValue - minValue).roundToDouble() / 3,
    ];
  }

  List<FlSpot> getAccountSpots() {
    List<MapEntry<double, double>> finalData = getXYMapValues();
    return finalData.map((pair) => FlSpot(pair.key, pair.value)).toList();
  }

  List<LineChartBarData> linesBarData1() {
    return [
      LineChartBarData(
        spots: getAccountSpots(),
        curveSmoothness: 0.01,
        isCurved: true,
        colors: [
          selectedAccountIndex == -1
              ? Colors.white
              : getSelectedAccount().color,
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      )
    ];
  }

  ///

  void toggleBalanceCustom(bool value) {
    balanceCustom = value;
    notifyListeners();
  }

  void toggleExpenseBreakdownCustom(bool value) {
    expenseBreakdownCustom = value;
    notifyListeners();
  }

  void toggleAmountTrendCustom(bool value) {
    amountTrendCustom = value;
    notifyListeners();
  }
}
