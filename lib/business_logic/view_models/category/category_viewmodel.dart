import 'package:flutter/cupertino.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/category/category_basemodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';

class CategoryViewModel extends ChangeNotifier implements CategoryBaseModel {
  UserData userData;
  List<Category> categories;
  Category originalCategory;
  Category tempCategory;

  CategoryViewModel({this.userData}) {
    categories = userData.categories;
  }

  void editCategory(Category category) {
    originalCategory = Category.of(category);
    tempCategory = Category.of(category);
  }

  void addCategory(Category category) {
    category.index = categories.length;
    categories.add(category);
    userData.addCategory(category);
  }

  void updateCategory() {}

  void deleteCategory(Category category) {}
}
