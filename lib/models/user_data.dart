import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapsheetapp/models/record.dart';

import '../archive/account.dart';
import '../archive/category.dart';

class UserData extends ChangeNotifier {
  int _selectedAccount = -1;
  Record _tempRecord;
  bool _isEditing = false;

  List<String> _accountTitles = [
    "Cash",
  ];

  List<String> _categoryTitles = [
    'Food & Beverage',
    'Transportation',
    'Fashion',
    'Movies',
    'Medicine',
    'Groceries',
    'Games',
    'Movies',
    'Recreation',
    'Lodging'
  ];

  List<Icon> _categoryIcons = [
    Icon(FontAwesomeIcons.utensils),
    Icon(FontAwesomeIcons.shuttleVan),
    Icon(FontAwesomeIcons.shoppingBag),
    Icon(FontAwesomeIcons.film),
    Icon(FontAwesomeIcons.pills),
    Icon(FontAwesomeIcons.shoppingCart),
    Icon(FontAwesomeIcons.gamepad),
    Icon(FontAwesomeIcons.film),
    Icon(FontAwesomeIcons.umbrellaBeach),
    Icon(FontAwesomeIcons.hotel),
  ];

  List<Record> _records = [];

  List<Record> get allRecords {
    return _records;
  }

  List<Record> get specifiedRecords {
    return _selectedAccount == -1
        ? allRecords
        : _records.where((rec) => rec.accountId == _selectedAccount).toList();
  }

  int get recordsCount {
    return _records.length;
  }

  int get selectedAccount {
    return _selectedAccount;
  }

  int get categoriesCount {
    return _categoryTitles.length;
  }

  List<String> get accounts {
    return _accountTitles;
  }

  List<String> get categoryTitles {
    return _categoryTitles;
  }

  List<Icon> get categoryIcons {
    return _categoryIcons;
  }

  Record get tempRecord {
    return _tempRecord;
  }

  bool get isEditing {
    return _isEditing;
  }

  void addRecord() {
    if (_tempRecord.title == "untitled") {
      _tempRecord.rename(_categoryTitles[_tempRecord.categoryId]);
    }

    if (!_isEditing) {
      allRecords.add(_tempRecord);
    }

    if (_isEditing) {
      _isEditing = false;
    }

    notifyListeners();
  }

  void addAccount(String accTitle) {
    _accountTitles.add(accTitle);
    _isExport.add(true);
    notifyListeners();
  }

  void addCategory(String categoryTitle, Icon icon) {
    _categoryTitles.add(categoryTitle);
    _categoryIcons.add(icon);
    notifyListeners();
  }

  void selectAccount(int accId) {
    _selectedAccount = accId;
    notifyListeners();
  }

  void newRecord() {
    _tempRecord = new Record(
        "untitled", 0, DateTime.now(), Record.catId, Record.accId, "SGD");
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

  void renameAccount(int accId, String newTitle) {
    accounts.removeAt(accId);
    accounts.insert(accId, newTitle);
    notifyListeners();
  }

  String _recordsToString(Record rec) {
    String cat = _categoryTitles[rec.categoryId];
    String cur = rec.currency;
    double val = rec.value;
    return "$cat: $cur$val";
  }

  double get statsTotal {
    double total = 0;
    for (Record rec in allRecords) {
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
      for (Record rec in allRecords) {
        res += "- ${_recordsToString(rec)}";
        total += rec.value;
      }
      res += "\nTotal value: $total";
    } else {
      res += "Records from ${_accountTitles[_selectedAccount]}:\n";
      for (Record rec in allRecords) {
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
  List<bool> _isExport = [true];

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

//  void getCSV() async {
//    List<List<dynamic>> rows = List<List<dynamic>>();
//
//    List<Record> filtered = _records.where((e) =>
//        exportSelection.contains(e.accountId) &&
//        (e.date.isAfter(exportStart) && e.date.isBefore(exportEnd)));
//
//    for (Record r in filtered) {
//      List<dynamic> row = List();
//      row.add(r.date);
//      row.add(r.title);
//      row.add(r.value);
//      row.add(accounts[r.accountId]);
//      row.add(categoryTitles[r.categoryId]);
//      row.add(r.currency);
//      rows.add(row);
//    }
//
//    String csv = const ListToCsvConverter().convert(rows);
//
//    final String dir = (await getApplicationDocumentsDirectory()).path;
//    final String path = '$dir/snapsheet.csv';
//    final File file = File(path);
//
//    await file.writeAsString(csv);
//  }
}
