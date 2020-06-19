import 'dart:io';

class Record {
  static int catId = 0;
  static int accId = 0;

  String title;
  double value;
  DateTime date;
  int categoryId;
  int accountId;
  String currency;
  bool isIncome;
  File image;
  String url;

  Record.fromReceipt({
    this.title,
    this.value,
    this.date,
    this.categoryId,
    this.accountId,
    this.currency = 'SGD',
    this.isIncome = false,
    this.image,
  });

  Record(
    this.title,
    this.value,
    this.date,
    this.categoryId,
    this.accountId, [
    this.currency = 'SGD',
    this.isIncome = false,
  ]);
}
