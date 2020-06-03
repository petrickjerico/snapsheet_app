import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:snapsheetapp/models/record.dart';

import 'account.dart';

class AccountsData extends ChangeNotifier {
  List<Account> _accounts = [
    Account('Account 1'),
    Account('Account 2'),
    Account('Account 3'),
  ];

  List<Account> get accounts {
    return _accounts;
  }

  void addExpenseToAccount(Record rec, Account acc) {
    int index = _accounts.indexWhere((element) => element.equals(acc));
    _accounts[index].add(rec);
    notifyListeners();
  }
}
