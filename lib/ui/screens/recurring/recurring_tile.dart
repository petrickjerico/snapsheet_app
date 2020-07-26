import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/recurring/recurring_viewmodel.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/screens/recurring/add_recurring_screen.dart';

class RecurringTile extends StatelessWidget {
  Recurring recurring;
  int index;

  RecurringTile({this.recurring, this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        Category category =
            model.userData.getThisCategory(recurring.categoryUid);
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          dense: true,
          leading: CircleAvatar(
            backgroundColor: category.color.withOpacity(0.2),
            child: IconTheme(
              data: IconThemeData(color: category.color, size: 15),
              child: FaIcon(category.icon.icon),
            ),
          ),
          title: Text(
            recurring.title,
            style:
                Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18.0),
          ),
          subtitle: Text(
            recurring.recurrency,
            style:
                Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 12.0),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                (recurring.isIncome ? "" : "-") +
                    recurring.value.toStringAsFixed(2),
                style: Theme.of(context).textTheme.headline6.copyWith(
                    color:
                        recurring.isIncome ? Colors.green : Colors.redAccent),
              ),
              Text(
                model.getAccountFromUid(recurring.accountUid).title ?? "",
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          ),
          onTap: () {
            model.editTempRecurring(index);
            Navigator.pushNamed(context, AddRecurringScreen.id);
          },
        );
      },
    );
  }
}
