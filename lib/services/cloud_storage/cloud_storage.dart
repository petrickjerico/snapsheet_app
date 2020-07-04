import 'package:snapsheetapp/business_logic/models/models.dart';

abstract class CloudStorageService {
  Future<void> addReceiptURL(Record record);
  Future<void> deleteCloudImage(Record record);
}
