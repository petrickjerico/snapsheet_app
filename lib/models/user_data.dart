import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snapsheetapp/models/account.dart';
import 'package:snapsheetapp/models/category.dart';
import 'package:snapsheetapp/models/record.dart';
import 'package:snapsheetapp/services/export.dart';
import 'package:sorted_list/sorted_list.dart';

class UserData extends ChangeNotifier {
  int _selectedAccount = -1;
  Record _tempRecord;
  bool _isEditing = false;
  Exporter _exporter;
  bool _isScanned = false;
  static int imageCounter = 0;
  List<Record> records =
      SortedList<Record>((r1, r2) => r2.date.compareTo(r1.date));

  UserData() {
    records.addAll([
      Record("Steam Dota", 12, DateTime(2020, 4, 12), 3, 0, "SGD"),
      Record("UNIQLO", 30, DateTime(2020, 5, 12), 2, 0, "SGD"),
      Record("Mother's Day", 20, DateTime(2020, 5, 10), 2, 0, "SGD"),
      Record("Sentosa Outing", 14.50, DateTime(2020, 2, 12), 3, 1, "SGD"),
      Record("Netflix Subscription", 12, DateTime(2020, 6, 1), 3, 0, "SGD"),
      Record("Food & Beverage", 5.8, DateTime(2020, 5, 29), 0, 1, "SGD"),
      Record("Dental check up", 30, DateTime(2020, 6, 3), 4, 1, "SGD"),
      Record("First Aid kit", 20, DateTime(2020, 3, 12), 4, 2, "SGD"),
      Record("Group outing", 15, DateTime(2020, 4, 5), 0, 2, "SGD"),
      Record("Bus transport", 25, DateTime(2020, 5, 6), 1, 2, "SGD"),
      Record("CCA book", 16.75, DateTime(2020, 5, 3), 5, 2, "SGD"),
      Record("Online course", 5.75, DateTime(2020, 5, 20), 6, 2, "SGD"),
      Record("Teacher's Birthday Gift", 4, DateTime(2020, 4, 3), 3, 2, "SGD"),
    ]);
  }

  List<Account> _accounts = [
    Account(
        accTitle: 'DBS', accColor: Colors.red[900], accIndex: 0, accOrder: 0),
    Account(
        accTitle: 'Cash',
        accColor: Colors.deepPurple[700],
        accIndex: 1,
        accOrder: 1),
    Account(
        accTitle: 'CCA', accColor: Colors.blue[600], accIndex: 2, accOrder: 2),
  ];

  List<Category> _categories = [
    Category('Food & Drinks', Icon(FontAwesomeIcons.utensils), Colors.red),
    Category(
        'Transportation', Icon(FontAwesomeIcons.shuttleVan), Colors.blueGrey),
    Category(
        'Shopping', Icon(FontAwesomeIcons.shoppingBag), Colors.lightBlueAccent),
    Category('Entertainment', Icon(FontAwesomeIcons.glassCheers),
        Colors.deepPurpleAccent),
    Category('Health', Icon(FontAwesomeIcons.pills), Colors.indigoAccent),
    Category('Education', Icon(FontAwesomeIcons.graduationCap), Colors.orange),
    Category('Electronics', Icon(FontAwesomeIcons.tv), Colors.teal),
    Category(
        'Income', Icon(FontAwesomeIcons.moneyBill), Colors.amberAccent, true),
    Category('Others', Icon(Icons.category), Colors.black),
  ];

  List<Record> get specifiedRecords => _selectedAccount == -1
      ? records
      : records.where((rec) => rec.accountId == _selectedAccount).toList();

  int get recordsCount => records.length;

  int get selectedAccount => _selectedAccount;

  int get categoriesCount => _categories.length;

  List<Account> get accounts => _accounts;

  List<Category> get categories => _categories;

  Record get tempRecord => _tempRecord;

  bool get isEditing => _isEditing;

  bool get isScanned => _isScanned;

  void toggleScanned() {
    _isScanned = !_isScanned;
  }

  void addRecord() {
    if (!_isEditing) {
      records.add(_tempRecord);
    }

    if (_isEditing) {
      _isEditing = false;
    }

    notifyListeners();
  }

  void addAccount(String title, Color color) {
    _accounts.add(Account(accTitle: title, accColor: color));
    notifyListeners();
  }

  void addCategory(String categoryTitle, Icon icon) {
    _categories.add(Category(categoryTitle, icon, Colors.black));
    notifyListeners();
  }

  void selectAccount(int accId) {
    _selectedAccount = accId;
    notifyListeners();
  }

  void newRecord() {
    _tempRecord =
        new Record("", 0, DateTime.now(), Record.catId, Record.accId, "SGD");
    notifyListeners();
  }

  void changeCategory(int catId) {
    _tempRecord.categoryId = catId;
    notifyListeners();
  }

  void changeAccount(int accId) {
    _tempRecord.accountId = accId;
    notifyListeners();
  }

  void changeValue(double newValue) {
    _tempRecord.value = newValue;
    notifyListeners();
  }

  void changeTempRecord(int recordIndex) {
    _tempRecord = records[recordIndex];
    _isEditing = true;
    notifyListeners();
  }

  void changeImage(File imageFile) {
    _tempRecord.image = imageFile;
    notifyListeners();
  }

  void editAccount(int accId, String newTitle, Color newColor) {
    accounts.firstWhere((acc) => acc.accIndex == accId).title = newTitle;
    accounts.firstWhere((acc) => acc.accIndex == accId).color = newColor;
    notifyListeners();
  }

  bool recordMatchesStats(Record rec) {
    return (_selectedAccount == -1 || rec.accountId == _selectedAccount);
  }

  double get statsExpensesTotal {
    double total = 0;
    for (Record rec in records) {
      if (!rec.isIncome && recordMatchesStats(rec)) {
        total += rec.value;
      }
    }
    return num.parse(total.toStringAsFixed(2));
  }

  void changeTitle(String newTitle) {
    _tempRecord.title = newTitle;
    notifyListeners();
  }

  void changeDate(DateTime newDate) {
    _tempRecord.date = newDate;
    notifyListeners();
  }

  Exporter get exporter => _exporter;

  void Export() {
    _exporter = Exporter(records, accounts, categories);
  }

  void toggleExport(index) {
    _exporter.toggleExport(index);
    notifyListeners();
  }

  void deleteAccount(int accId) {
    accounts.removeWhere((acc) => acc.accIndex == accId);
    records.removeWhere((rec) => rec.accountId == accId);
    _selectedAccount--;
    notifyListeners();
  }

  double statsGetCategTotalFromCurrent(int catId) {
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

  List<Record> statsGetRecords(int limit) {
    List<Record> res = [];

    for (Record rec in records) {
      if (res.length == limit) {
        break;
      }
      if (recordMatchesStats(rec)) {
        res.add(rec);
      }
    }

    return res;
  }

  int statsCountRecords(int accId) {
    int count = 0;
    for (Record rec in records) {
      if (rec.accountId == accId) {
        count++;
      }
    }
    return count;
  }

  double statsGetAccountTotal(int accId) {
    double total = 0;
    for (Record rec in records) {
      if (rec.accountId == accId) {
        total += rec.value;
      }
    }
    return total;
  }

  List<Account> orderGetAccounts() {
    List<Account> res = [];
    for (Account acc in accounts) {
      res.insert(acc.accOrder, acc);
    }
    return res;
  }

  void orderUpdateAccount(int pos, int newIndex) {
    _accounts[pos].order = newIndex;
    notifyListeners();
  }
}
