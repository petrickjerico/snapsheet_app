import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:snapsheetapp/business_logic/default_data/recurring.dart';

class Recurring {
  String uid;

  String title;
  double value;
  int categoryId;
  String accountUid;
  bool isIncome;

  DateTime nextRecurrence;
  int frequencyId;
  int timeFrameId;
  int interval;

  DateTime untilDate;
  int xTimes;

  Recurring({
    this.uid,
    this.title,
    this.value,
    this.categoryId,
    this.accountUid,
    this.isIncome,
    this.nextRecurrence,
    this.frequencyId,
    this.timeFrameId,
    this.interval,
    this.untilDate,
    this.xTimes,
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
      frequencyId: json['frequencyId'],
      timeFrameId: json['timeFrameId'],
      interval: json['interval'],
      untilDate: json['untilDate'],
      xTimes: json['xTimes'],
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
      'frequencyId': frequencyId,
      'timeFrameId': timeFrameId,
      'interval': interval,
      'untilDate': untilDate,
      'xTimes': xTimes,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }

  String get recurrency {
    String timeFrame;
    if (timeFrameId == FOREVER) {
      timeFrame = 'Forever';
    } else if (timeFrameId == UNTILDATE) {
      timeFrame = 'Until ${DateFormat.yMMMd().format(untilDate)}';
    } else {
      timeFrame = 'For ${xTimes} time(s)';
    }

    String next = "Next: ${DateFormat.yMMMd().format(nextRecurrence)}";
    return interval > 1
        ? "Repeat every $interval ${plural[frequencyId]} | $next | $timeFrame"
        : "Repeat ${frequencies[frequencyId]} | $next | $timeFrame";
  }
}
