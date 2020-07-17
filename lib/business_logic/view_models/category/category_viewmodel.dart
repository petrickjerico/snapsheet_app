import 'package:flutter/cupertino.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/category/category_basemodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';

class CategoryViewModel extends ChangeNotifier implements CategoryBaseModel {
  UserData userData;
  List<Category> categories;
  List<Category> customCategories;

  CategoryViewModel({this.userData}) {}
}
