import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snapsheetapp/business_logic/models/category.dart';

List<Category> categories = [
  Category.unnamed(
      'Food & Drinks', Icon(FontAwesomeIcons.utensils), Colors.red),
  Category.unnamed(
      'Transportation', Icon(FontAwesomeIcons.shuttleVan), Colors.blueGrey),
  Category.unnamed(
      'Shopping', Icon(FontAwesomeIcons.shoppingBag), Colors.lightBlueAccent),
  Category.unnamed('Entertainment', Icon(FontAwesomeIcons.glassCheers),
      Colors.deepPurpleAccent),
  Category.unnamed('Health', Icon(FontAwesomeIcons.pills), Colors.indigoAccent),
  Category.unnamed(
      'Education', Icon(FontAwesomeIcons.graduationCap), Colors.orange),
  Category.unnamed('Electronics', Icon(FontAwesomeIcons.tv), Colors.teal),
  Category.unnamed('Giving', Icon(FontAwesomeIcons.gift), Colors.pinkAccent),
  Category.unnamed(
      'Income', Icon(FontAwesomeIcons.moneyBill), Colors.amberAccent, true),
  Category.unnamed('Others', Icon(Icons.category), Colors.black),
];
