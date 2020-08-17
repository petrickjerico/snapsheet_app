import 'package:flutter/material.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data/user_data_impl.dart';

abstract class CategoryBaseModel {
  /// Initialize the model with UserData.
  void init(UserData userData);

  /// To toggle between Custom Categories and All Categories view.
  void toggleView();

  /// Initialize the new category.
  void newCategory();

  /// Add the newly made category.
  void addCategory();

  /// Initialization for editing the selected custom category.
  void editCategory(Category category);

  /// Confirm the changes on the edited custom category.
  void updateCategory();

  /// Update the new/selected category's attribute with the new value.
  void changeColor(Color newColor);
  void changeIsIncome();
  void changeIcon(Icon newIcon);
  void changeTitle(String newTitle);

  void deleteCategory(Category category);
}
