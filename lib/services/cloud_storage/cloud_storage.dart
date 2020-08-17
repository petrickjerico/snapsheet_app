import 'package:snapsheetapp/business_logic/models/models.dart';

abstract class CloudStorageService {
  /// Upload the image in the record to Cloud Firestore and
  /// return the url to fetch the image.
  Future<String> addReceiptURL(Record record);

  /// Clear the image from Cloud Firestore when the user
  /// delete the image or delete the record.
  Future<void> deleteCloudImage(Record record);
}
