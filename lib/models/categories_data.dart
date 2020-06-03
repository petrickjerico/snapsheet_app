import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'category.dart';

class CategoriesData extends ChangeNotifier {
  List<Category> _categories = [
    Category(
      'Food & Beverage',
      Icon(FontAwesomeIcons.utensils),
    ),
    Category(
      'Transportation',
      Icon(FontAwesomeIcons.shuttleVan),
    ),
    Category(
      'Fashion',
      Icon(FontAwesomeIcons.shoppingBag),
    ),
    Category(
      'Movies',
      Icon(FontAwesomeIcons.film),
    ),
    Category(
      'Medicine',
      Icon(FontAwesomeIcons.pills),
    ),
    Category(
      'Groceries',
      Icon(FontAwesomeIcons.shoppingCart),
    ),
    Category(
      'Games',
      Icon(FontAwesomeIcons.gamepad),
    ),
    Category(
      'Movies',
      Icon(FontAwesomeIcons.film),
    ),
    Category(
      'Recreation',
      Icon(FontAwesomeIcons.umbrellaBeach),
    ),
    Category(
      'Lodging',
      Icon(FontAwesomeIcons.hotel),
    ),
  ];

  List<Category> get categories {
    return _categories;
  }

  void addCategory(String categoryTitle) {
    _categories.add(Category(categoryTitle, Icon(Icons.category)));
    notifyListeners();
  }
}
