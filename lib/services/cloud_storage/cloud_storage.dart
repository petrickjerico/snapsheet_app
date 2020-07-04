import 'package:snapsheetapp/business_logic/models/models.dart';

abstract class CloudStorageService {
  Future<String> getReceiptURL(Record record);
  Future<void> clearLocalImage(Record record);
  Future<void> deleteCloudImage(Record record);
}
