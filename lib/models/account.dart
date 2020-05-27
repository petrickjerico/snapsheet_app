import 'package:snapsheetapp/models/record.dart';

class Account {
  String _accountTitle;
  List<Record> _accountRecords;

  Account(String accountTitle) {
    this._accountTitle = accountTitle;
  }

  String get title {
    return _accountTitle;
  }

  List<Record> get records {
    return _accountRecords;
  }

  void add(Record newRecord) {
    _accountRecords.add(newRecord);
  }

  void rename(String newTitle) {
    _accountTitle = newTitle;
  }
}
