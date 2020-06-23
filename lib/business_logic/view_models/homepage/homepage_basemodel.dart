import 'package:snapsheetapp/business_logic/models/models.dart';

abstract class HomepageBaseModel {
  Future loadData();

  // CREATE
  Future addRecord(Record record);
  Future addAccount(Account account);

  // READ
  List<Record> get records;

  // UPDATE
  Future updateRecord(int index, Record record);

  // DELETE
  Future deleteRecord(Record record);
}
