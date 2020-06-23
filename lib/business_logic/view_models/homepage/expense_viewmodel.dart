import 'package:flutter/cupertino.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/expense_basemodel.dart';
import 'package:snapsheetapp/services/database/database_impl.dart';
import 'package:sorted_list/sorted_list.dart';

class ExpenseViewModel extends ChangeNotifier implements ExpenseBaseModel {
  final User user;
  DatabaseService _db;

  List<Record> _records =
      SortedList<Record>((r1, r2) => r2.dateTime.compareTo(r1.dateTime));
  List<Account> _accounts =
      SortedList<Account>((a1, a2) => a1.index.compareTo(a2.index));
  List<Category> _categories =
      SortedList<Category>((c1, c2) => c1.index.compareTo(c2.index));

  Record _tempRecord;

  ExpenseViewModel(this.user) {
    _db = DatabaseServiceImpl(uid: user.uid);
    loadData();
  }

  void loadData() async {
    List<Record> unorderedRecords = await _db.getRecords();
    List<Account> unorderedAccounts = await _db.getAccounts();
    List<Category> unorderedCategories = await _db.getCategories();
    _records.addAll(unorderedRecords);
    _accounts.addAll(unorderedAccounts);
    _categories.addAll(unorderedCategories);
    notifyListeners();
  }

  void setTempRecord(Record record) {
    _tempRecord = record;
  }

  // CREATE
  Future addRecord(Record record) async {
    _records.add(record);
    notifyListeners();
    Future<String> uid = _db.addRecord(record);
    record.uid = await uid;
  }

  // READ
  List<Record> get records => _records;
  List<Account> get accounts => _accounts;
  List<Category> get categories => _categories;
  Record get tempRecord => _tempRecord;

  // UPDATE
  Future updateRecord(int index, Record record) async {
    _db.updateRecord(record);
    _records.removeAt(index);
    _records.add(record);
    notifyListeners();
  }

  // DELETE
  Future deleteRecord(Record record) async {
    _db.deleteRecord(record);
    print(record.uid);
    _records.remove(record);
    notifyListeners();
  }


}
