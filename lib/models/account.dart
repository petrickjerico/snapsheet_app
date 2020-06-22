import 'package:flutter/material.dart';

class Account {
  static int accountIndexGen = 0;

  String accountTitle;
  Color accountColor;
  int accountId;
  int accountOrder;
  bool isSelected = true;

  Account(String accTitle, Color accColor, int accOrder) {
    assert(accountIndexGen != null, 'accIndexGen not initialised.');
    this.accountTitle = accTitle;
    this.accountColor = accColor;
    this.accountId = accountIndexGen;
    this.accountOrder = accOrder;
    accountIndexGen++;
  }

  String get title => accountTitle;

  Color get color => accountColor;

  int get index => accountId;

  int get order => accountOrder;

  set title(String value) {
    accountTitle = value;
  }

  set color(Color value) {
    accountColor = value;
  }

  set order(int value) {
    accountOrder = value;
  }
}
