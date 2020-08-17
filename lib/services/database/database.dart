import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/models/recurring.dart';

abstract class DatabaseService {
  // Initialize DatabaseService with UserDocument and CollectionReferences
  Future<void> initialize();

  // CREATE
  Future<String> addRecord(Record record);
  Future<String> addAccount(Account account);
  Future<String> addRecurring(Recurring recurring);
  Future<String> addCategory(Category category);

  // READ
  Future<List<Record>> getRecords();
  Future<List<Account>> getAccounts();
  Future<List<Recurring>> getRecurrings();
  Future<List<Category>> getCategories();

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
