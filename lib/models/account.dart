import 'package:flutter/material.dart';

class Account {
  String accTitle;
  Color accColor;
  int accIndex;
  int accOrder;
  bool isSelected = true;

  Account({this.accTitle, this.accColor, this.accIndex, this.accOrder});

  String get title => accTitle;

  Color get color => accColor;

  int get index => accIndex;

  int get order => accOrder;

  set title(String value) {
    accTitle = value;
  }

  set color(Color value) {
    accColor = value;
  }

  set order(int value) {
    accOrder = value;
  }
}
