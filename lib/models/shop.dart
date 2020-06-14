import 'package:snapsheetapp/models/category.dart';

class Shop {
  String lowercased;
  String shopTitle;
  int catId;

  Shop({this.lowercased, this.shopTitle, this.catId});

  String get lowercase => lowercased;

  String get title => shopTitle;

  int get categoryId => catId;
}
