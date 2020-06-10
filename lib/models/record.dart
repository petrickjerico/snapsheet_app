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
  File _receiptImage;
  String _receiptURL;

  Record(this._title, this._value, this._dateTime, this._categoryId,
      this._accountId,
      [this._currency = 'SGD']);

  String get title {
    return _title;
  }

  double get value {
    return _value;
  }

  DateTime get date {
    return _dateTime;
  }

  int get categoryId {
    return _categoryId;
  }

  int get accountId {
    return _accountId;
  }

  String get currency {
    return _currency;
  }

  File get image {
    return _receiptImage;
  }

  void rename(String newTitle) {
    _title = newTitle;
  }

  void revalue(double newValue) {
    _value = newValue;
  }

  void redate(DateTime newDate) {
    _dateTime = newDate;
  }

  void recategorise(int newCategoryId) {
    _categoryId = newCategoryId;
  }

  void reaccount(int newAccountId) {
    _accountId = newAccountId;
  }

  void reimage(File newImage) {
    _receiptImage = newImage;
  }

  void changeCurrency(String newCurrency) {
    // TODO: change _recordValue to correspond to the given newCurrency.
    // For now, changeCurrency() only changes the appended currency String
    // before _recordValue.
    _currency = newCurrency;
  }
}
