import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snapsheetapp/business_logic/models/category.dart';

const FOODDRINKS = 0;
const TRANSPORTATION = 1;
const SHOPPING = 2;
const ENTERTAINMENT = 3;
const HEALTH = 4;
const EDUCATION = 5;
const ELECTRONICS = 6;
const GIVING = 7;
const INCOME = 8;
const OTHERS = 9;

List<Category> defaultCategories = [
  foodDrinks,
  transportation,
  entertainment,
  health,
  education,
  electronics,
  giving,
  income,
  others,
];

Category foodDrinks = Category(
  title: 'Food & Drinks',
  icon: Icon(Icons.fastfood),
  color: Colors.redAccent,
  isIncome: false,
  index: FOODDRINKS,
);

Category transportation = Category(
  title: 'Transportation',
  icon: Icon(FontAwesomeIcons.car),
  color: Colors.orangeAccent,
  isIncome: false,
  index: TRANSPORTATION,
);

Category entertainment = Category(
  title: 'Entertainment',
  icon: Icon(FontAwesomeIcons.gamepad),
  color: Colors.tealAccent,
  isIncome: false,
  index: ENTERTAINMENT,
);

Category health = Category(
  title: 'Health',
  icon: Icon(FontAwesomeIcons.pills),
  color: Colors.lightBlueAccent,
  isIncome: false,
  index: HEALTH,
);

Category education = Category(
  title: 'Education',
  icon: Icon(FontAwesomeIcons.graduationCap),
  color: Colors.blueAccent,
  isIncome: false,
  index: EDUCATION,
);

Category electronics = Category(
  title: 'Electronics',
  icon: Icon(FontAwesomeIcons.tv),
  color: Colors.indigoAccent,
  isIncome: false,
  index: ELECTRONICS,
);

Category giving = Category(
  title: 'Giving',
  icon: Icon(FontAwesomeIcons.gifts),
  color: Colors.purpleAccent,
  isIncome: false,
  index: GIVING,
);

Category income = Category(
  title: 'Income',
  icon: Icon(FontAwesomeIcons.moneyBillWave),
  color: Colors.green,
  isIncome: true,
  index: INCOME,
);

Category others = Category(
    title: 'Others',
    icon: Icon(FontAwesomeIcons.shapes),
    color: Colors.grey,
    isIncome: false,
    index: OTHERS);
