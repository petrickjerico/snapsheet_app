import 'package:flutter/material.dart';

class TempData extends ChangeNotifier {
  double _dummyVar;

  double get dummyVar {
    return _dummyVar;
  }

  void changeValue(double val) {
    _dummyVar = val;
  }
}
