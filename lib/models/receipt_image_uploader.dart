import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class ReceiptUploader {
  Future<String> upload(File imageFile) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('receipts/${p.basename(imageFile.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.onComplete;
    print('File Uploaded');
    String fileURL = await storageReference.getDownloadURL();
    print(fileURL);
    return fileURL;
  }
}
