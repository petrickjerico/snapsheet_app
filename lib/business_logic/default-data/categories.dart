import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snapsheetapp/business_logic/models/category.dart';

List<Category> _categories = [
  Category('Food & Drinks', Icon(FontAwesomeIcons.utensils), Colors.red),
  Category(
      'Transportation', Icon(FontAwesomeIcons.shuttleVan), Colors.blueGrey),
  Category(
      'Shopping', Icon(FontAwesomeIcons.shoppingBag), Colors.lightBlueAccent),
  Category('Entertainment', Icon(FontAwesomeIcons.glassCheers),
      Colors.deepPurpleAccent),
  Category('Health', Icon(FontAwesomeIcons.pills), Colors.indigoAccent),
  Category('Education', Icon(FontAwesomeIcons.graduationCap), Colors.orange),
  Category('Electronics', Icon(FontAwesomeIcons.tv), Colors.teal),
  Category(
      'Income', Icon(FontAwesomeIcons.moneyBill), Colors.amberAccent, true),
  Category('Others', Icon(Icons.category), Colors.black),
];
