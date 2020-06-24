import 'package:snapsheetapp/business_logic/models/models.dart';

abstract class UserDataBaseModel {
  void loadData();

  // CREATE
  Future addRecord(Record record);
  Future addAccount(Account account);
//  Future addCategory(Category category);

  // READ
  List<Record> get records;
  List<Account> get accounts;
//  List<Category> get categories;

  // UPDATE
  Future<void> updateRecord(Record record);
  Future<void> updateAccount(Account account);
//  Future<void> updateCategory(int index, Category category);

  // DELETE
  Future<void> deleteRecord(Record record);
  Future<void> deleteAccount(Account account);
//  Future<void> deleteCategory(Category category);
}
