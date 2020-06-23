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
  bool toDelete;

  Record.fromReceipt({
    this.title,
    this.value,
    this.dateTime,
    this.categoryId,
    this.accountId,
    this.isIncome = false,
    this.image,
    this.toDelete,
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
      this.uid});

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
