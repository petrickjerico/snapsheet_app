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

  @override
  String toString() {
    return "Category($title, ${icon.icon.toString()}, [${color.toString()}, $isIncome])";
  }
}
