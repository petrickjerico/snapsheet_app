export 'cloud_storage.dart';

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';

import 'cloud_storage.dart';

class CloudStorageServiceImpl implements CloudStorageService {
  final String uid;
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://snapsheet-e7f7b.appspot.com/');

  CloudStorageServiceImpl({this.uid});

  Future<String> getReceiptURL(Record record) async {
    File image = File(record.imagePath);

    // Upload to Firebase
    String cloudFilePath = 'receipts/$uid/${record.uid}.png';
    StorageReference storageReference = _storage.ref().child(cloudFilePath);
    StorageUploadTask _uploadTask;

    _uploadTask = storageReference.putFile(image);
    StorageTaskSnapshot taskSnapshot = await _uploadTask.onComplete;
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> clearLocalImage(Record record) async {
    File image = File(record.imagePath);
    await image.delete();
    record.imagePath = null;
  }

  Future<void> deleteCloudImage(Record record) async {
    if (record.receiptURL != null) {
      String cloudFilePath = 'receipts/$uid/${record.uid}.png';
      StorageReference storageReference = _storage.ref().child(cloudFilePath);
      await storageReference.delete();
    }
  }
}
