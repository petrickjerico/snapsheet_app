import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Account {
  String title;
  Color color;
  int index;
  String uid;

  Account.demo(String accTitle, Color accColor, int accOrder) {
    this.title = accTitle;
    this.color = accColor;
    this.index = accOrder;
  }

  Account copyWith(
      {String accTitle, Color accColor, int accOrder, String uid}) {
    return Account(
      title: accTitle ?? this.title,
      color: accColor ?? this.color,
      index: accOrder ?? this.index,
      uid: uid ?? this.uid,
    );
  }

  Account({this.title, this.color, this.index, this.uid});

  factory Account.of(Account account) {
    return Account(
      title: account.title,
      color: account.color,
      index: account.index,
      uid: account.uid,
    );
  }

  factory Account.fromFirestore(DocumentSnapshot doc) {
    Map json = doc.data;

    return Account(
        title: json['title'],
        color: Color(json['color']),
        index: json['order'],
        uid: json['uid']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'color': color.value,
      'order': index,
      'uid': uid,
    };
  }
}
