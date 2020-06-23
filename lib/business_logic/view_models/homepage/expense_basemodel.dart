import 'package:snapsheetapp/business_logic/models/models.dart';

abstract class ExpenseBaseModel {
  void loadData();

  // CREATE
  Future addRecord(Record record);

  // READ
  List<Record> get records;
  List<Account> get accounts;
  List<Category> get categories;

  // UPDATE
  Future updateRecord(int index, Record record);

  // DELETE
  Future deleteRecord(Record record);
}
