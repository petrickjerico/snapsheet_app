import 'package:flutter/cupertino.dart';
import 'package:snapsheetapp/business_logic/default_data/categories.dart';
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

  void init(UserData userData) {
    this.userData = userData;
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

  void changeColor(Color newColor) {
    tempCategory.color = newColor;
  }

  void changeIsIncome() {
    tempCategory.isIncome = !tempCategory.isIncome;
  }

  void changeIcon(Icon newIcon) {
    tempCategory.icon = newIcon;
  }

  void changeTitle(String newTitle) {
    tempCategory.title = newTitle;
  }

  void deleteCategory(Category category) {
    userData.deleteCategory(category);
    List<Record> newRecords = List.from(userData.records);
    for (Record record in newRecords) {
      if (record.categoryUid == category.uid) {
        record.categoryUid = categories[OTHERS].uid;
        userData.updateRecord(record);
      }
    }
    int deletedCategoryIndex = category.index;
    for (Category category in categories) {
      if (category.index > deletedCategoryIndex) {
        category.index--;
        userData.updateCategory(category);
      }
    }
    notifyListeners();
  }
}
