import 'package:flutter/material.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'record.dart';
import 'account.dart';
import 'category.dart';

class TempData extends ChangeNotifier {
  Account _account;
  Record _record;

  TempData() {
    _account = UserData().accounts[0];
    _record = Record.init();
  }

  Record get record {
    return _record;
  }

  Account get account {
    return _account;
  }

  void updateTargetAccount(Account acc) {
    _account = acc;
    notifyListeners();
    print("Target account changed!");
  }

  void revalueCurrentRecord(double value) {
    _record.revalue(value);
    notifyListeners();
    print("Record revalued!");
  }

  void recategoriseCurrentRecord(Category cat) {
    _record.recategorise(cat);
    notifyListeners();
    print("Record recategorised!");
  }
}
