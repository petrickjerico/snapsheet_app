import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category {
  String title;
  Icon icon;
  Color color;
  bool isIncome;
  int index;
  bool isDefault;
  String uid;

  Category.unnamed(int index, String title, Icon icon, bool isDefault,
      [Color color, bool isIncome]) {
    this.index = index;
    this.title = title;
    this.icon = icon;
    this.isDefault = isDefault;
    this.color = color;
    this.isIncome = isIncome ?? false;
  }

  Category({
    this.title,
    this.icon,
    this.color,
    this.isIncome,
    this.index,
    this.isDefault,
    this.uid,
  });

  factory Category.newBlankCategory() {
    return Category(
      title: "",
      icon: Icon(FontAwesomeIcons.question),
      color: Colors.orange,
      isIncome: false,
      isDefault: false,
    );
  }

  factory Category.of(Category category) {
    return Category(
      title: category.title,
      icon: category.icon,
      color: category.color,
      isIncome: category.isIncome,
      index: category.index,
      isDefault: category.isDefault,
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
      isDefault: json['isDefault'],
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
      'isDefault': isDefault,
      'uid': uid
    };
  }

  @override
  String toString() {
    return "Category($title, ${icon.icon.toString()}, [${color.toString()}, $isIncome])";
  }
}
