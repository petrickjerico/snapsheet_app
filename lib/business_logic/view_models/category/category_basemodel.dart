import 'package:flutter/material.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data/user_data_impl.dart';

abstract class CategoryBaseModel {
  void init(UserData userData);
  void toggleView();
  void editCategory(Category category);
  void newCategory();
  void addCategory();
  void updateCategory();
  void changeColor(Color newColor);
  void changeIsIncome();
  void changeIcon(Icon newIcon);
  void changeTitle(String newTitle);
  void deleteCategory(Category category);
}
