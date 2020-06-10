import 'package:snapsheetapp/models/category.dart';

class Shop {
  String lowercased;
  String shopTitle;
  int catId;

  Shop({this.lowercased, this.shopTitle, this.catId});

  String get lowercase {
    return lowercased;
  }

  String get title {
    return shopTitle;
  }

  int get categoryId {
    return catId;
  }
}
