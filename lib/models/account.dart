import 'package:flutter/material.dart';

class Account {
  String accTitle;
  Color accColor;
  bool isSelected = true;

  Account({this.accTitle, this.accColor});

  String get title => accTitle;

  Color get color => accColor;

  set title(String value) {
    accTitle = value;
  }

  set color(Color value) {
    accColor = value;
  }
}
