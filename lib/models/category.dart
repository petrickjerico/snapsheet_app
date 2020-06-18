import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class Category {
  static final _randomColor = RandomColor();
  String _title;
  Icon _icon;
  Color _color;
  bool _isIncome;

  Category(String title, Icon icon, [Color color, bool isIncome]) {
    this._title = title;
    this._icon = icon;
    this._color = color ?? _randomColor.randomColor();
    this._isIncome = isIncome ?? false;
  }

  String get title => _title;

  Icon get icon => _icon;

  Color get color => _color;

  bool get isIncome => _isIncome;

  @override
  String toString() {
    return "Category($title, ${icon.icon.toString()}, [${color.toString()}, $isIncome])";
  }
}
