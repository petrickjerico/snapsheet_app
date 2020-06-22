import 'package:flutter/material.dart';

class Account {
  static int accIndexGen = 0;

  String accTitle;
  Color accColor;
  int accIndex;
  int accOrder;
  bool isSelected = true;

  Account(String accTitle, Color accColor, int accOrder) {
    assert(accIndexGen != null, 'accIndexGen not initialised.');
    this.accTitle = accTitle;
    this.accColor = accColor;
    this.accIndex = accIndexGen;
    this.accOrder = accOrder;
    accIndexGen++;
  }

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
