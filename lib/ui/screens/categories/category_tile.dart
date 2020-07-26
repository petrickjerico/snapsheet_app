import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/category/category_viewmodel.dart';
import 'package:snapsheetapp/ui/components/dialog/delete_dialog.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/config/decoration.dart';
import 'package:snapsheetapp/ui/screens/categories/category_popup.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  final bool tappable;

  CategoryTile({this.category, this.tappable});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryViewModel>(
      builder: (context, model, child) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          dense: true,
          onTap: tappable ? () => Navigator.pop(context, category.index) : null,
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: category.color.withOpacity(0.2),
            child: IconTheme(
              data: IconThemeData(color: category.color, size: 20),
              child: FaIcon(category.icon.icon),
            ),
          ),
          title: Text(
            category.title,
            style: kHistoryRecordTitle.copyWith(color: Colors.white),
          ),
          trailing: category.isDefault
              ? SizedBox.shrink()
              : Container(
                  width: 100,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.white,
                        onPressed: () {
                          model.editCategory(category);
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SingleChildScrollView(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: CategoryPopUp(),
                            ),
                            shape: kBottomSheetShape,
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.white,
                        onPressed: () {
                          showDialog(
                            context: context,
                            child: DeleteDialog(
                                title: 'Delete Category',
                                message:
                                    'Are you sure you want to delete ${category.title}?',
                                onDelete: () {
                                  model.deleteCategory(category);
                                  Navigator.pop(context);
                                }),
                          );
                        },
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
