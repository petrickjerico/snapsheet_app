import 'package:flutter/cupertino.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_basemodel.dart';
import 'package:snapsheetapp/services/database/database_impl.dart';
import 'package:sorted_list/sorted_list.dart';

class UserData extends ChangeNotifier implements UserDataBaseModel {
  final User user;
  DatabaseService _db;

  List<Record> _records =
      SortedList<Record>((r1, r2) => r2.dateTime.compareTo(r1.dateTime));
  List<Account> _accounts =
      SortedList<Account>((a1, a2) => a1.index.compareTo(a2.index));
  List<Category> _categories =
      SortedList<Category>((c1, c2) => c1.index.compareTo(c2.index));

  UserData(this.user) {
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

  // CREATE
  Future addRecord(Record record) async {
    _records.add(record);
    notifyListeners();
    Future<String> uid = _db.addRecord(record);
    record.uid = await uid;
  }

  Future addAccount(Account account) async {
    _accounts.add(account);
    notifyListeners();
    Future<String> uid = _db.addAccount(account);
    account.uid = await uid;
  }

  Future addCategory(Category category) async {
    _categories.add(category);
    notifyListeners();
    Future<String> uid = _db.addCategory(category);
    category.uid = await uid;
  }

  // READ
  List<Record> get records => _records;
  List<Account> get accounts => _accounts;
  List<Category> get categories => _categories;

  // UPDATE
  Future<void> updateRecord(int index, Record record) async {
    _db.updateRecord(record);
    _records.removeAt(index);
    _records.add(record);
  }

  Future<void> updateAccount(int index, Account account) async {
    _db.updateAccount(account);
    _accounts.removeAt(index);
    _accounts.add(account);
    notifyListeners();
  }

  Future<void> updateCategory(int index, Category category) async {
    _db.updateCategory(category);
    _categories.removeAt(index);
    _categories.add(category);
    notifyListeners();
  }

  // DELETE
  Future<void> deleteRecord(Record record) async {
    _db.deleteRecord(record);
    print(record.uid);
    _records.remove(record);
    notifyListeners();
  }

  Future<void> deleteAccount(Account account) async {
    _db.deleteAccount(account);
    print(account.uid);
    _records.remove(account);
    notifyListeners();
  }

  Future<void> deleteCategory(Category category) async {
    _db.deleteCategory(category);
    print(category.uid);
    _records.remove(category);
    notifyListeners();
  }
}
