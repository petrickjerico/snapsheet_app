import 'package:flutter/material.dart';

class Account {
  String accTitle;
  Color accColor;

  Account({this.accTitle, this.accColor});

  String get title {
    return accTitle;
  }

  Color get color {
    return accColor;
  }

  void rename(String newTitle) {
    accTitle = newTitle;
  }
}
