import 'package:snapsheetapp/business_logic/models/models.dart';

abstract class UserDataBaseModel {
  /// Initialize the model with UserData.
  /// Load Callback is needed to signal to the frontend that
  /// it is done fetching data from database.
  Future<void> init(User user, Function loadCallback);

  /// Ensure that any due recurring records will be added.
  void addDueExpenses();

  /// CREATE
  Future<void> addRecord(Record record);
  Future<void> addAccount(Account account);
  Future<void> addRecurring(Recurring recurring);
  Future<void> addCategory(Category category);

  /// READ
  List<Record> get records;
  List<Account> get accounts;
  List<Recurring> get recurrings;
  List<Category> get categories;
  Account getThisAccount(String accountUid);
  Category getThisCategory(String categoryUid);

  /// UPDATE
  Future<void> updateRecord(Record record);
  Future<void> updateAccount(Account account);
  Future<void> updateRecurring(Recurring recurring);
  Future<void> updateCategory(Category category);

  /// Clear all demo data and initialize the user with empty state.
  Future<void> demoDone();

  /// DELETE
  Future<void> deleteRecord(Record record);
  Future<void> deleteAccount(Account account);
  Future<void> deleteRecurring(Recurring recurring);
  Future<void> deleteCategory(Category category);
}
