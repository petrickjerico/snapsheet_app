import 'package:flutter/material.dart';

class Category {
  final String _title;
  final Icon _icon;
  final Color _color;

  Category(this._title, this._icon, this._color);

  String get title {
    return _title;
  }

  Icon get icon {
    return _icon;
  }

  Color get color {
    return _color;
  }
}
