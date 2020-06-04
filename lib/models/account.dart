import 'package:flutter/material.dart';
import 'package:snapsheetapp/models/record.dart';

class Account extends ChangeNotifier {
  static int _counter = 1;
  String _accountTitle;
  List<Record> _accountRecords;

  Account.init() {
    this._accountTitle = "Untitled Account $_counter";
    _counter++;
    this._accountRecords = [];
  }

  Account(String accountTitle) {
    this._accountTitle = accountTitle;
    this._accountRecords = [];
  }

  String get title {
    return _accountTitle;
  }

  List<Record> get records {
    return _accountRecords;
  }

  void add(Record newRecord) {
    _accountRecords.add(newRecord);
    notifyListeners();
  }

  void rename(String newTitle) {
    _accountTitle = newTitle;
    notifyListeners();
  }

  String toString() {
    String res = "$_accountTitle has the following Expenses:";

    for (Record rec in _accountRecords) {
      res += "\n- ${rec.toString()}";
    }

    return res;
  }

  bool equals(Account acc) {
    return acc.title == this._accountTitle;
  }
}
