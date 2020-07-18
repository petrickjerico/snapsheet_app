import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/category/category_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/ui/config/colors.dart';
import 'package:snapsheetapp/ui/screens/categories/category_popup.dart';
import 'package:snapsheetapp/ui/screens/categories/category_tile.dart';
import 'package:snapsheetapp/ui/screens/sidebar/sidebar_menu.dart';

const int TOGGLEDEFAULT = 1;
const int ADDCATEGORY = 2;

class CategoryScreen extends StatelessWidget {
  static const String id = 'category_screen';

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context, listen: false);
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
        body: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.white30,
          ),
          itemCount: model.showDefault
              ? model.categories.length
              : model.customCategories.length,
          itemBuilder: (context, index) {
            return CategoryTile(
                category: model.showDefault
                    ? model.categories[index]
                    : model.customCategories[index]);
          },
        ),
      );
    });
  }
}
