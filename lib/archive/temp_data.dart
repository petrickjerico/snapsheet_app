import 'package:flutter/material.dart';
import 'package:snapsheetapp/models/account.dart';
import 'package:snapsheetapp/models/user_data.dart';
import '../models/record.dart';
import 'account.dart';
import 'category.dart';

class TempData extends ChangeNotifier {
  double _dummyVar;

  double get dummyVar {
    return _dummyVar;
  }

  void changeValue(double val) {
    _dummyVar = val;
  }
}
