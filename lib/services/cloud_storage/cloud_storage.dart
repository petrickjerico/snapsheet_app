import 'package:snapsheetapp/business_logic/models/models.dart';

abstract class CloudStorageService {
  Future<String> addReceiptURL(Record record);
  Future<void> deleteCloudImage(Record record);
}
