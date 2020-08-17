import 'package:snapsheetapp/business_logic/models/models.dart';

abstract class UserDataBaseModel {
  // CREATE
  Future addRecord(Record record);
  Future addAccount(Account account);
  Future addRecurring(Recurring recurring);
  Future addCategory(Category category);

  // READ
  List<Record> get records;
  List<Account> get accounts;
  List<Recurring> get recurrings;
  List<Category> get categories;

  // UPDATE
  Future<void> updateRecord(Record record);
  Future<void> updateAccount(Account account);
  Future<void> updateRecurring(Recurring recurring);
  Future<void> updateCategory(Category category);

  // DELETE
  Future<void> deleteRecord(Record record);
  Future<void> deleteAccount(Account account);
  Future<void> deleteRecurring(Recurring recurring);
  Future<void> deleteCategory(Category category);
}
