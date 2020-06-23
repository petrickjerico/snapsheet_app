import 'package:snapsheetapp/business_logic/models/models.dart';

abstract class DatabaseService {
  // CREATE
  Future<String> addRecord(Record record);
  Future<String> addAccount(Account account);
//  Future<String> addCategory(Category category);

  // READ
  Future<List<Record>> getRecords();
  Future<List<Account>> getAccounts();
//  Future<List<Category>> getCategories();

  // UPDATE
  Future<void> updateRecord(Record record);
  Future<void> updateAccount(Account account);
//  Future<void> updateCategory(Category category);

  // DELETE
  Future<void> deleteRecord(Record record);
  Future<void> deleteAccount(Account account);
//  Future<void> deleteCategory(Category category);
}
