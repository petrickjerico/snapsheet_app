import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_basemodel.dart';
import 'package:snapsheetapp/services/cloud_storage/cloud_storage.dart';
import 'package:snapsheetapp/services/cloud_storage/cloud_storage_impl.dart';
import 'package:snapsheetapp/services/database/database_impl.dart';
import 'package:sorted_list/sorted_list.dart';

class UserData extends ChangeNotifier implements UserDataBaseModel {
  User user;
  DatabaseServiceImpl _db;
  CloudStorageService _cloud;

  List<Record> _records =
      SortedList<Record>((r1, r2) => r2.dateTime.compareTo(r1.dateTime));
  List<Account> _accounts =
      SortedList<Account>((a1, a2) => a1.index.compareTo(a2.index));
  List<Recurring> _recurrings = SortedList<Recurring>(
      (r1, r2) => r1.nextRecurrence.compareTo(r2.nextRecurrence));
  List<Category> _categories =
      SortedList<Category>((c1, c2) => c1.index.compareTo(c2.index));

  Future init(User user, Function loadCallback) async {
    this.user = user;

    _records.clear();
    _accounts.clear();
    _recurrings.clear();
    _categories.clear();

    _db = DatabaseServiceImpl(uid: user.uid);
    _cloud = CloudStorageServiceImpl(uid: user.uid);

    List<Record> unorderedRecords = await _db.getRecords();
    List<Account> unorderedAccounts = await _db.getAccounts();
    List<Recurring> unorderedRecurrings = await _db.getRecurrings();
    List<Category> unorderedCategories = await _db.getCategories();

    _records.addAll(unorderedRecords);
    _accounts.addAll(unorderedAccounts);
    _recurrings.addAll(unorderedRecurrings);
    _categories.addAll(defaultCategories);
    _categories.addAll(unorderedCategories);

    loadCallback();
  }

  Future processImage(Record record) async {
    if (record.imagePath != null) {
      record.receiptURL = await _cloud.addReceiptURL(record);
      record.hasCloudImage = true;
      record.imagePath = null;
    } else if (record.imagePath == null &&
        record.receiptURL == null &&
        record.hasCloudImage) {
      _cloud.deleteCloudImage(record);
      record.hasCloudImage = false;
    }
  }

  /// CREATE
  Future addRecord(Record record) async {
    _records.add(record);
    notifyListeners();

    Future<String> uid = _db.addRecord(record);
    record.uid = await uid;
    await processImage(record);

    _db.updateRecord(record);
  }

  Future addAccount(Account account) async {
    _accounts.add(account);
    notifyListeners();
    Future<String> uid = _db.addAccount(account);
    account.uid = await uid;
  }

  Future addRecurring(Recurring recurring) async {
    _recurrings.add(recurring);
    notifyListeners();
    Future<String> uid = _db.addRecurring(recurring);
    recurring.uid = await uid;
  }

  Future addCategory(Category category) async {
    _categories.add(category);
    notifyListeners();
    Future<String> uid = _db.addCategory(category);
    category.uid = await uid;
  }

  /// READ
  List<Record> get records => _records;
  List<Account> get accounts => _accounts;
  List<Recurring> get recurrings => _recurrings;
  List<Category> get categories => _categories;

  Account getThisAccount(String accountUid) {
    return accounts.firstWhere((acc) {
      return acc.uid == accountUid;
    });
  }

  /// UPDATE
  Future<void> updateRecord(Record record) async {
    await processImage(record);
    _db.updateRecord(record);
  }

  Future<void> updateAccount(Account account) async {
    _db.updateAccount(account);
  }

  Future<void> updateRecurring(Recurring recurring) async {
    _db.updateRecurring(recurring);
  }

  Future<void> updateCategory(Category category) async {
    _db.updateCategory(category);
  }

  /// DELETE
  Future<void> deleteRecord(Record record) async {
    _cloud.deleteCloudImage(record);
    _records.removeWhere((rec) => rec.uid == record.uid);
    _db.deleteRecord(record);
  }

  Future<void> deleteAccount(Account account) async {
    _accounts.removeWhere((acc) => acc.uid == account.uid);
    _db.deleteAccount(account);
  }

  Future<void> deleteRecurring(Recurring recurring) async {
    _recurrings.removeWhere((rec) => rec.uid == recurring.uid);
    _db.deleteRecurring(recurring);
  }

  Future<void> deleteCategory(Category category) async {
    _categories.removeWhere((cat) => cat.uid == category.uid);
    _db.deleteCategory(category);
  }
}
