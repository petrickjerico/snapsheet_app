import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snapsheetapp/models/account.dart';
import 'package:snapsheetapp/models/category.dart';
import 'package:snapsheetapp/models/export.dart';
import 'package:snapsheetapp/models/record.dart';

class UserData extends ChangeNotifier {
  int _selectedAccount = -1;
  Record _tempRecord;
  bool _isEditing = false;

  List<Account> _accounts = [
    Account(accTitle: 'DBS', accColor: Colors.red),
    Account(accTitle: 'Cash', accColor: Colors.amber),
  ];

  List<Category> _categories = [
    Category('Food & Drinks', Icon(FontAwesomeIcons.utensils), Colors.red),
    Category(
        'Transportation', Icon(FontAwesomeIcons.shuttleVan), Colors.blueGrey),
    Category('Shopping', Icon(FontAwesomeIcons.shoppingBag), Colors.pinkAccent),
    Category('Entertainment', Icon(FontAwesomeIcons.glassCheers),
        Colors.deepPurpleAccent),
    Category('Health', Icon(FontAwesomeIcons.pills), Colors.indigoAccent),
    Category('Education', Icon(FontAwesomeIcons.graduationCap), Colors.orange),
    Category('Electronics', Icon(FontAwesomeIcons.phone), Colors.teal),
    Category('Income', Icon(FontAwesomeIcons.moneyBill), Colors.amberAccent),
    Category('Others', Icon(Icons.category), Colors.black)
  ];

//  Record(this._title, this._value, this._dateTime, this._categoryId,
//      this._accountId, this._currency);
  List<Record> _records = [
    Record("Steam Dota", 12, DateTime(2020, 4, 12), 3, 0, "SGD"),
    Record("UNIQLO", 30, DateTime(2020, 5, 12), 2, 0, "SGD"),
    Record("Mother's Day", 20, DateTime(2020, 5, 10), 2, 0, "SGD"),
    Record("Sentosa Outing", 14.50, DateTime(2020, 2, 12), 3, 1, "SGD"),
    Record("Netflix Subscription", 12, DateTime(2020, 6, 1), 3, 0, "SGD"),
    Record("Food & Beverage", 5.8, DateTime(2020, 5, 29), 0, 1, "SGD"),
    Record("Dental check up", 30, DateTime(2020, 6, 3), 4, 1, "SGD"),
  ];

  List<Record> get records {
    return _records;
  }

  List<Record> get specifiedRecords {
    return _selectedAccount == -1
        ? records
        : _records.where((rec) => rec.accountId == _selectedAccount).toList();
  }

  int get recordsCount {
    return _records.length;
  }

  int get selectedAccount {
    return _selectedAccount;
  }

  int get categoriesCount {
    return _categories.length;
  }

  List<Account> get accounts {
    return _accounts;
  }

  List<Category> get categories {
    return _categories;
  }

  Record get tempRecord {
    return _tempRecord;
  }

  bool get isEditing {
    return _isEditing;
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
    _isExport.add(true);
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
    _tempRecord.recategorise(catId);
    notifyListeners();
  }

  void changeAccount(int accId) {
    _tempRecord.reaccount(accId);
    notifyListeners();
  }

  void changeValue(double newValue) {
    _tempRecord.revalue(newValue);
    notifyListeners();
  }

  void changeTempRecord(int recordIndex) {
    _tempRecord = _records[recordIndex];
    _isEditing = true;
    notifyListeners();
  }

  void changeImage(File imageFile) {
    _tempRecord.reimage(imageFile);
    notifyListeners();
  }

  void renameAccount(int accId, String newTitle) {
    accounts[accId].rename(newTitle);
    notifyListeners();
  }

  String _recordsToString(Record rec) {
    String cat = _categories[rec.categoryId].title;
    String cur = rec.currency;
    double val = rec.value;
    return "$cat: $cur$val";
  }

  double get statsTotal {
    double total = 0;
    for (Record rec in records) {
      if (_selectedAccount == -1 || rec.accountId == _selectedAccount) {
        total += rec.value;
      }
    }
    return total;
  }

  String get selectedStatistics {
    String res = "";
    double total = 0;

    if (_selectedAccount == -1) {
      res += "Records from all accounts combined:\n";
      for (Record rec in records) {
        res += "- ${_recordsToString(rec)}";
        total += rec.value;
      }
      res += "\nTotal value: $total";
    } else {
      res += "Records from ${_accounts[_selectedAccount].title}:\n";
      for (Record rec in records) {
        if (rec.accountId == _selectedAccount) {
          res += "\n- ${_recordsToString(rec)}";
          total += rec.value;
        }
      }
      res += "\nTotal value: $total";
    }
    return res;
  }

  void changeTitle(String newTitle) {
    _tempRecord.rename(newTitle);
    notifyListeners();
  }

  void changeDate(DateTime newDate) {
    _tempRecord.redate(newDate);
    notifyListeners();
  }

  String get statistics {
//    String res;
//
//    if (_selectedAccount == -1) {
//      res += "Records from all accounts:";
//      for ()
//    }
    return selectedAccount.toString();
  }

  // EXPORT SECTION
  List<bool> _isExport = [true, true];

  int get accountCount {
    return _isExport.length;
  }

  List<bool> get isExport {
    return _isExport;
  }

  void toggleExport(int accId) {
    _isExport[accId] = !_isExport[accId];
    notifyListeners();
  }

  void exportCSV() {
    Exporter(
            records: records,
            accounts: accounts.map((acc) => acc.title).toList(),
            categoryTitles: categories.map((cat) => cat.title).toList(),
            isExport: isExport)
        .exportCSV();
  }
}
