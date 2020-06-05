import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snapsheetapp/models/record.dart';
import 'package:sorted_list/sorted_list.dart';

class UserData extends ChangeNotifier {
  int _selectedAccount = -1;
  Record _tempRecord;

  List<String> _accountTitles = [
    "Account 1",
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

  SortedList<Record> _records =
      SortedList<Record>((r1, r2) => r2.date.compareTo(r1.date));

  List<Record> get records {
    return _records;
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

  void addRecord() {
    if (_tempRecord.title == "untitled") {
      _tempRecord.rename(_categoryTitles[_tempRecord.categoryId]);
    }
    records.add(_tempRecord);
    notifyListeners();
  }

  void addAccount(String accTitle) {
    _accountTitles.add(accTitle);
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

  String get statistics {
//    String res;
//
//    if (_selectedAccount == -1) {
//      res += "Records from all accounts:";
//      for ()
//    }
    return selectedAccount.toString();
  }
}
