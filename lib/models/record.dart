import 'dart:io';

class Record {
  static int catId = 0;
  static int accId = 0;

  String _title;
  double _value;
  DateTime _dateTime;
  int _categoryId;
  int _accountId;
  String _currency;
  bool _isIncome;
  File _receiptImage;
  String _receiptURL;

  Record(
    this._title,
    this._value,
    this._dateTime,
    this._categoryId,
    this._accountId, [
    this._currency = 'SGD',
    this._isIncome = false,
  ]);

  String get title => _title;

  double get value => _value;

  DateTime get date => _dateTime;

  int get categoryId => _categoryId;

  int get accountId => _accountId;

  String get currency => _currency;

  bool get isIncome => _isIncome;

  File get image => _receiptImage;

  set name(String newTitle) {
    _title = newTitle;
  }

  set value(double newValue) {
    _value = newValue;
  }

  set date(DateTime newDate) {
    _dateTime = newDate;
  }

  set category(int newCategoryId) {
    _categoryId = newCategoryId;
  }

  set account(int newAccountId) {
    _accountId = newAccountId;
  }

  set isIncome(bool newIsIncome) {
    _isIncome = newIsIncome;
  }

  set image(File newImage) {
    _receiptImage = newImage;
  }

  set currency(String newCurrency) {
    // TODO: change _recordValue to correspond to the given newCurrency.
    // For now, changeCurrency() only changes the appended currency String
    // before _recordValue.
    _currency = newCurrency;
  }
}
