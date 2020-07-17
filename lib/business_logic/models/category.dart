import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:snapsheetapp/business_logic/default_data/categories.dart';

class Category {
  String title;
  Icon icon;
  Color color;
  bool isIncome;
  int index;
  String uid;

  Category.unnamed(int index, String title, Icon icon,
      [Color color, bool isIncome]) {
    this.index = index;
    this.title = title;
    this.icon = icon;
    this.color = color;
    this.isIncome = isIncome ?? false;
  }

  Category(
      {this.title, this.icon, this.color, this.isIncome, this.index, this.uid});

  factory Category.of(Category category) {
    return Category(
      title: category.title,
      icon: category.icon,
      color: category.color,
      isIncome: category.isIncome,
      index: category.index,
      uid: category.uid,
    );
  }

  factory Category.fromFirestore(DocumentSnapshot doc) {
    Map json = doc.data;

    return Category(
      title: json['title'],
      icon: Icon(IconData(json['codePoint'],
          fontFamily: json['fontFamily'], fontPackage: json['fontPackage'])),
      color: Color(json['color']),
      isIncome: json['isIncome'],
      index: json['index'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'codePoint': icon.icon.codePoint,
      'fontFamily': icon.icon.fontFamily,
      'fontPackage': icon.icon.fontPackage,
      'color': color.value,
      'isIncome': isIncome,
      'index': index,
      'uid': uid
    };
  }

  @override
  String toString() {
    return "Category($title, ${icon.icon.toString()}, [${color.toString()}, $isIncome])";
  }
}
