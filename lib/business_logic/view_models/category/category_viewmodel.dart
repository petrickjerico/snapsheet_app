import 'package:flutter/cupertino.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/category/category_basemodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';

class CategoryViewModel extends ChangeNotifier implements CategoryBaseModel {
  UserData userData;
  List<Category> customCategories = [];
  List<Category> categories;
  Category originalCategory;
  Category tempCategory;
  bool isEditing = false;
  bool showDefault = true;

  CategoryViewModel({this.userData}) {
    categories = userData.categories;
    for (Category category in categories) {
      if (category.isDefault) continue;
      customCategories.add(category);
    }
  }

  void toggleView() {
    showDefault = !showDefault;
    notifyListeners();
  }

  void editCategory(Category category) {
    isEditing = true;
    originalCategory = Category.of(category);
    tempCategory = Category.of(category);
  }

  void newCategory() {
    tempCategory = Category.newBlankCategory();
  }

  void addCategory(Category category) {
    category.index = categories.length;
    categories.add(category);
    userData.addCategory(category);
  }

  void updateCategory() {
    userData.updateCategory(tempCategory);
    categories[tempCategory.index] = tempCategory;
  }

  void deleteCategory(Category category) {
    userData.deleteCategory(category);
    categories.removeWhere((element) => element.uid == category.uid);
  }
}
