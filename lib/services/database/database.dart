import 'package:snapsheetapp/business_logic/models/models.dart';

abstract class DatabaseService {
  Future<String> addRecord(Record record);

  Future<void> updateRecord(Record record);

  Future<void> deleteRecord(Record record);

  Future<List<Record>> getAllRecords();
}
