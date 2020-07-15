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

  factory Recurring.newBlank() {
    return Recurring(
      title: "",
      value: 0,
      categoryId: 0,
      isIncome: false,
      nextRecurrence: DateTime.now(),
      frequencyId: MONTHLY,
      timeFrameId: FOREVER,
      interval: 1,
      untilDate: DateTime.now().add(Duration(days: 7)),
      xTimes: 1,
    );
  }

  factory Recurring.of(Recurring recurring) {
    return Recurring(
      title: recurring.title,
      value: recurring.value,
      categoryId: recurring.categoryId,
      isIncome: recurring.isIncome,
      nextRecurrence: recurring.nextRecurrence,
      frequencyId: recurring.frequencyId,
      timeFrameId: recurring.timeFrameId,
      interval: recurring.interval,
      untilDate: recurring.untilDate,
      xTimes: recurring.xTimes,
    );
  }

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
      untilDate: DateTime.fromMillisecondsSinceEpoch(json['untilDate']),
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
      'untilDate': untilDate.millisecondsSinceEpoch,
      'xTimes': xTimes,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }

  String get frequency {
    if (interval > 1) {
      return "Repeat every $interval ${plural[frequencyId]}";
    } else {
      return "Repeat ${frequencies[frequencyId]}";
    }
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
    return "$frequency\n$next\n$timeFrame";
  }
}
