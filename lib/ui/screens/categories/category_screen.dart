import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/category/category_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/ui/screens/categories/category_tile.dart';

class CategoryScreen extends StatelessWidget {
  static const String id = 'category_screen';

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context, listen: false);
    return ChangeNotifierProvider<CategoryViewModel>(
      create: (context) => CategoryViewModel(userData: userData),
      child: Consumer<CategoryViewModel>(builder: (context, model, child) {
        return Scaffold(
          body: ListView.builder(
            itemCount: model.categories.length,
            itemBuilder: (context, index) {
              return CategoryTile(category: model.categories[index]);
            },
          ),
        );
      }),
    );
  }
}
