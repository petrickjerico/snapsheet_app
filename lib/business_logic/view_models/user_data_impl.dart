import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_basemodel.dart';
import 'package:snapsheetapp/services/database/database_impl.dart';
import 'package:sorted_list/sorted_list.dart';

class UserData extends ChangeNotifier implements UserDataBaseModel {
  User user;
  DatabaseService _db;
  Function loadCallback;
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://snapsheet-e7f7b.appspot.com/');

  List<Record> _records =
      SortedList<Record>((r1, r2) => r2.dateTime.compareTo(r1.dateTime));
  List<Account> _accounts =
      SortedList<Account>((a1, a2) => a1.index.compareTo(a2.index));

  void init(User user, Function loadCallback) {
    this.loadCallback = loadCallback;
    this.user = user;
    _db = DatabaseServiceImpl(uid: user.uid);
    loadData();
  }

  void loadData() async {
    List<Record> unorderedRecords = await _db.getRecords();
    List<Account> unorderedAccounts = await _db.getAccounts();
    _records.addAll(unorderedRecords);
    _accounts.addAll(unorderedAccounts);
    loadCallback();
  }

//  Future wipeData() async {
//    print("WIPE DATA");
//    _records = [];
//    _accounts = [];
//    isDemo = false;
//    notifyListeners();
//    _records.forEach((record) => _db.deleteRecord(record));
//    _accounts.forEach((account) => _db.deleteAccount(account));
//  }

  Future<Record> _getReceiptURL(Record record) async {
    if (record.imagePath != null) {
      File image = File(record.imagePath);

      // Upload to Firebase
      String cloudFilePath = 'receipts/${user.uid}/${record.uid}.png';
      StorageReference storageReference = _storage.ref().child(cloudFilePath);
      StorageUploadTask _uploadTask;

      _uploadTask = storageReference.putFile(image);
      StorageTaskSnapshot taskSnapshot = await _uploadTask.onComplete;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      record.receiptURL = downloadURL;

      // Delete image cache from device
      await image.delete();

      // Delete imagePath attributes
      record.imagePath = null;
    }
    return record;
  }

  // CREATE
  Future addRecord(Record record) async {
    _records.add(record);
    notifyListeners();
    Future<String> uid = _db.addRecord(record);
    record.uid = await uid;
    print(record);

    // Add receiptURL
    Future<Record> updatedRecord = _getReceiptURL(record);
    _db.updateRecord(await updatedRecord);
  }

  Future addAccount(Account account) async {
    _accounts.add(account);
    notifyListeners();
    Future<String> uid = _db.addAccount(account);
    account.uid = await uid;
  }

  // READ
  List<Record> get records => _records;
  List<Account> get accounts => _accounts;
  Account getThisAccount(String accountUid) {
    return accounts.firstWhere((acc) {
      return acc.uid == accountUid;
    });
  }

  // UPDATE
  Future<void> updateRecord(Record record) async {
    Future<Record> updatedRecord = _getReceiptURL(record);
    _db.updateRecord(await updatedRecord);
  }

  Future<void> updateAccount(Account account) async {
    _db.updateAccount(account);
  }

  // DELETE
  Future<void> deleteRecord(Record record) async {
    _records.removeWhere((rec) => rec.uid == record.uid);
    _db.deleteRecord(record);
  }

  Future<void> deleteAccount(Account account) async {
    _accounts.removeWhere((acc) => acc.uid == account.uid);
    _db.deleteAccount(account);
  }
}
