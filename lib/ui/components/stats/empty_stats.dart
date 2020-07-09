import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/homepage_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/ui/screens/expense/expense_screen.dart';

class EmptyStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Consumer<ExpenseViewModel>(builder: (context, expenseModel, child) {
          return GestureDetector(
            child: Icon(
              Icons.add_circle,
              color: Colors.white24,
              size: 120.0,
            ),
            onTap: () {
              final model =
                  Provider.of<HomepageViewModel>(context, listen: false);
              expenseModel.newRecord();
              expenseModel.changeAccount(model.getSelectedAccount().index);
              Navigator.pushNamed(context, ExpenseScreen.id);
            },
          );
        }),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'No records found for this account yet.\nTap to create one.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white30, fontSize: 15),
          ),
        )
      ],
    );
  }
}
