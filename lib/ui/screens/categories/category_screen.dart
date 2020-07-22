import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/category/category_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/ui/config/colors.dart';
import 'package:snapsheetapp/ui/screens/categories/category_popup.dart';
import 'package:snapsheetapp/ui/screens/categories/category_tile.dart';
import 'package:snapsheetapp/ui/screens/sidebar/sidebar_menu.dart';

class CategoryScreen extends StatelessWidget {
  static const String id = 'category_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryViewModel>(builder: (context, model, child) {
      return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: kBlack,
        drawer: SidebarMenu(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kHomepageBackgroundTransparency,
          title: Text('CATEGORIES'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                  model.showDefault ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                model.toggleView();
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                model.newCategory();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: CategoryPopUp(),
                  ),
                );
              },
            )
          ],
        ),
        body: ListView.builder(
          itemCount: model.showDefault
              ? model.categories.length
              : model.categories.where((cat) => !cat.isDefault).length,
          itemBuilder: (context, index) {
            List<Category> categories = model.showDefault
                ? model.categories
                : model.categories.where((cat) => !cat.isDefault).toList();
            return CategoryTile(category: categories[index], tappable: false);
          },
        ),
      );
    });
  }
}
