import 'package:cloud_firestore/cloud_firestore.dart';

class Recurring {
  String uid;

  String title;
  double value;
  int categoryId;
  String accountUid;
  bool isIncome;

  DateTime nextRecurrence;

  Duration interval;
  String intervalInString;

  Recurring({
    this.uid,
    this.title,
    this.value,
    this.categoryId,
    this.accountUid,
    this.isIncome,
    this.nextRecurrence,
    this.interval,
    this.intervalInString,
  });

  factory Recurring.fromFirestore(DocumentSnapshot doc) {
    Map json = doc.data;

    return Recurring(
      title: json['title'],
      value: json['value'],
      categoryId: json['categoryId'],
      accountUid: json['accountUid'],
      isIncome: json['isIncome'],
      nextRecurrence:
          DateTime.fromMillisecondsSinceEpoch(json['nextRecurrence']),
      interval: json['interval'],
      intervalInString: json['intervalInString'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'value': value,
      'categoryId': categoryId,
      'accountUid': accountUid,
      'isIncome': isIncome,
      'nextRecurrence': nextRecurrence.millisecondsSinceEpoch,
      'interval': interval.inMilliseconds,
      'intervalInString': intervalInString,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
