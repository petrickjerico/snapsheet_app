import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  String title;
  double value;
  DateTime dateTime;
  String categoryUid;
  int categoryId;
  String accountUid;
  int accountId;
  bool isIncome;
  String receiptURL;
  String uid;
  String imagePath;
  bool hasCloudImage;

  factory Record.newBlankRecord() {
    return Record(
      title: "",
      value: 0,
      dateTime: DateTime.now(),
      categoryId: 0,
      isIncome: false,
      hasCloudImage: false,
    );
  }

  Record.fromReceipt({
    this.title,
    this.value,
    this.dateTime,
    this.categoryId,
    this.accountUid,
    this.isIncome = false,
    this.imagePath,
  });

  Record.unnamed(
      this.title, this.value, this.dateTime, this.categoryId, this.accountId,
      [this.isIncome = false]);

  Record({
    this.title,
    this.value,
    this.dateTime,
    this.categoryId,
    this.accountUid,
    this.isIncome,
    this.receiptURL,
    this.uid,
    this.imagePath,
    this.hasCloudImage,
  });

  factory Record.of(Record record) {
    return Record(
      title: record.title,
      value: record.value,
      dateTime: record.dateTime,
      categoryId: record.categoryId,
      accountUid: record.accountUid,
      isIncome: record.isIncome,
      receiptURL: record.receiptURL,
      uid: record.uid,
      imagePath: record.imagePath,
      hasCloudImage: record.hasCloudImage,
    );
  }

  factory Record.fromFirestore(DocumentSnapshot doc) {
    Map json = doc.data;

    return Record(
      title: json['title'],
      value: json['value'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dateTime']),
      categoryId: json['categoryId'],
      accountUid: json['accountUid'],
      isIncome: json['isIncome'],
      receiptURL: json['receiptURL'],
      imagePath: json['imagePath'],
      hasCloudImage: json['hasCloudImage'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'value': value,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'categoryId': categoryId,
      'accountUid': accountUid,
      'isIncome': isIncome,
      'receiptURL': receiptURL,
      'imagePath': imagePath,
      'hasCloudImage': hasCloudImage,
      'uid': uid,
    };
  }

  @override
  String toString() {
    Map<String, dynamic> map = {
      'title': title,
      'value': value,
      'dateTime': dateTime,
      'categoryId': categoryId,
      'accountUid': accountUid,
      'isIncome': isIncome,
      'receiptURL': receiptURL,
      'imagePath': imagePath,
      'hasCloudImage': hasCloudImage,
      'uid': uid,
    };
    return map.toString();
  }
}
