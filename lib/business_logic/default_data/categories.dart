import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snapsheetapp/business_logic/models/category.dart';

List<Category> categories = [
  Category.unnamed('Food & Drinks', Icon(Icons.fastfood), Colors.redAccent),
  Category.unnamed(
      'Transportation', Icon(FontAwesomeIcons.car), Colors.orangeAccent),
  Category.unnamed('Shopping', Icon(Icons.shopping_basket), Colors.amberAccent),
  Category.unnamed(
      'Entertainment', Icon(FontAwesomeIcons.gamepad), Colors.tealAccent),
  Category.unnamed(
      'Health', Icon(FontAwesomeIcons.pills), Colors.lightBlueAccent),
  Category.unnamed(
      'Education', Icon(FontAwesomeIcons.graduationCap), Colors.blueAccent),
  Category.unnamed(
      'Electronics', Icon(FontAwesomeIcons.tv), Colors.indigoAccent),
  Category.unnamed('Giving', Icon(FontAwesomeIcons.gifts), Colors.purpleAccent),
  Category.unnamed(
      'Income', Icon(FontAwesomeIcons.moneyBillWave), Colors.green, true),
  Category.unnamed('Others', Icon(FontAwesomeIcons.shapes), Colors.grey),
];
