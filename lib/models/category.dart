import 'package:flutter/material.dart';

class Category {
  String _categoryTitle;
  Icon _categoryIcon;

  Category(this._categoryTitle, this._categoryIcon);

  String get categoryTitle {
    return _categoryTitle;
  }

  Icon get categoryIcon {
    return _categoryIcon;
  }

  Widget makeWidget() {
    return ListTile(
      leading: _categoryIcon,
      title: Text(_categoryTitle),
    );
  }
}
