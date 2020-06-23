import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class Category {
  static final _randomColor = RandomColor();
  String title;
  Icon icon;
  Color color;
  bool isIncome;

  Category(String title, Icon icon, [Color color, bool isIncome]) {
    this.title = title;
    this.icon = icon;
    this.color = color ?? _randomColor.randomColor();
    this.isIncome = isIncome ?? false;
  }

  @override
  String toString() {
    return "Category($title, ${icon.icon.toString()}, [${color.toString()}, $isIncome])";
  }
}
