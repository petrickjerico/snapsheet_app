import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Account {
  String title;
  Color color;
  int index;
  String uid;

  Account.unnamed(String accTitle, Color accColor, int accOrder) {
    this.title = accTitle;
    this.color = accColor;
    this.index = accOrder;
  }

  Account({this.title, this.color, this.index, this.uid});

  factory Account.fromFirestore(DocumentSnapshot doc) {
    Map json = doc.data;

    return Account(
        title: json['title'],
        color: Color(json['color']),
        index: json['index'],
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
