import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/category/category_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/ui/config/colors.dart';
import 'package:snapsheetapp/ui/screens/categories/category_tile.dart';
import 'package:snapsheetapp/ui/screens/sidebar/sidebar_menu.dart';

class CategoryScreen extends StatelessWidget {
  static const String id = 'category_screen';

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context, listen: false);
    return ChangeNotifierProvider<CategoryViewModel>(
      create: (context) => CategoryViewModel(userData: userData),
      child: Consumer<CategoryViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: kBlack,
            drawer: SidebarMenu(),
            body: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: model.categories[index].color,
              ),
              itemCount: model.categories.length,
              itemBuilder: (context, index) {
                return CategoryTile(category: model.categories[index]);
              },
            ),
            appBar: AppBar(
              title: Text('CATEGORIES'),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    print('pressed');
                  },
                  splashColor: Colors.transparent,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
