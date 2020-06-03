import 'package:snapsheetapp/models/category.dart';

class Record {
  String _recordTitle;
  double _recordValue;
  Category _recordCategory;
  String _recordCurrency;
  DateTime _dateTime;

  Record(this._recordTitle, this._recordValue, this._dateTime,
      this._recordCategory, this._recordCurrency);

  String get title {
    return _recordTitle;
  }

  double get value {
    return _recordValue;
  }

  DateTime get date {
    return _dateTime;
  }

  Category get category {
    return _recordCategory;
  }

  String get currency {
    return _recordCurrency;
  }

  void rename(String newTitle) {
    _recordTitle = newTitle;
  }

  void revalue(double newValue) {
    _recordValue = newValue;
  }

  void redate(DateTime newDate) {
    _dateTime = newDate;
  }

  void recategorise(Category newCategory) {
    _recordCategory = newCategory;
  }

  void changeCurrency(String newCurrency) {
    // TODO: change _recordValue to correspond to the given newCurrency.
    // For now, changeCurrency() only changes the appended currency String
    // before _recordValue.
    _recordCurrency = newCurrency;
  }

  String toString() {
    return "${_recordCategory.categoryTitle}: $_recordCurrency${_recordValue.toStringAsFixed(2)}";
  }
}
