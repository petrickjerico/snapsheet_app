import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class Category {
  static final _randomColor = RandomColor();
  String title;
  Icon icon;
  Color color;
  bool isIncome;
  int index;
  String uid;

  Category.unnamed(String title, Icon icon, [Color color, bool isIncome]) {
    this.title = title;
    this.icon = icon;
    this.color = color ?? _randomColor.randomColor();
    this.isIncome = isIncome ?? false;
  }

  Category({
    this.title,
    this.icon,
    this.color,
    this.isIncome,
    this.index,
    this.uid,
  });

  factory Category.fromFirestore(DocumentSnapshot doc) {
    Map json = doc.data;

    return Category(
        title: json['title'],
        icon: Icon(IconData(json['icon'])),
        color: Color(json['color']),
        isIncome: json['isIncome'],
        index: json['index'],
        uid: json['uid']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'icon': icon.icon.codePoint,
      'color': color.value,
      'isIncome': isIncome,
      'order': index,
      'uid': uid,
    };
  }

  @override
  String toString() {
    return "Category($title, ${icon.icon.toString()}, [${color.toString()}, $isIncome])";
  }
}
