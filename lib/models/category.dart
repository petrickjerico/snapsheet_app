import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class Category {
  static final _randomColor = RandomColor();
  String _title;
  Icon _icon;
  Color _color;

  Category(String title, Icon icon, [Color color]) {
    this._title = title;
    this._icon = icon;
    if (color != null) {
      this._color = color;
    } else {
      this._color = _randomColor.randomColor();
    }
  }

  String get title => _title;

  Icon get icon => _icon;

  Color get color => _color;
}
