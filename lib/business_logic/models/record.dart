import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  String title;
  double value;
  DateTime dateTime;
  int categoryId;
  int accountId;
  bool isIncome;
  String receiptURL;
  String uid;
  File image;

  factory Record.newBlankRecord() {
    return Record(
      title: "",
      value: 0,
      dateTime: DateTime.now(),
      categoryId: 0,
      accountId: 0,
      isIncome: false,
    );
  }

  Record.fromReceipt({
    this.title,
    this.value,
    this.dateTime,
    this.categoryId,
    this.accountId,
    this.isIncome = false,
    this.image,
  });

  Record.unnamed(
      this.title, this.value, this.dateTime, this.categoryId, this.accountId,
      [this.isIncome = false]);

  Record(
      {this.title,
      this.value,
      this.dateTime,
      this.categoryId,
      this.accountId,
      this.isIncome,
      this.receiptURL,
      this.uid,
      this.image});

  factory Record.of(Record record) {
    return Record(
      title: record.title,
      value: record.value,
      dateTime: record.dateTime,
      categoryId: record.categoryId,
      accountId: record.accountId,
      isIncome: record.isIncome,
      receiptURL: record.receiptURL,
      uid: record.uid,
      image: record.image,
    );
  }

  factory Record.fromFirestore(DocumentSnapshot doc) {
    Map json = doc.data;

    return Record(
        title: json['title'],
        value: json['value'],
        dateTime: DateTime.fromMillisecondsSinceEpoch(json['dateTime']),
        categoryId: json['categoryId'],
        accountId: json['accountId'],
        isIncome: json['isIncome'],
        receiptURL: json['receiptURL'],
        uid: json['uid']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'value': value,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'categoryId': categoryId,
      'accountId': accountId,
      'isIncome': isIncome,
      'receiptURL': receiptURL,
      'uid': uid
    };
  }
}
