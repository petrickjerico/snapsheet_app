import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/ui/screens/expense/expense_calculator.dart';

import 'edit_expense_info_screen.dart';

class ExpenseScreen extends StatelessWidget {
  static const String id = 'expense_screen';

  @override
  Widget build(BuildContext context) {
    print("BEFORE CONSUMER");
    return Consumer<ExpenseViewModel>(builder: (context, model, child) {
      print("AFTER CONSUMER");
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: BackButton(),
          title: Text('EXPENSES EDITOR'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, EditExpenseInfoScreen.id);
              },
            ),
            IconButton(
              icon: Icon(Icons.receipt),
              onPressed: () async {
                await model.showChoiceDialog(context);
                model.imageToTempRecord();
              },
            )
          ],
        ),
        body: ExpenseCalculator(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.check),
          onPressed: () {
            model.addRecord();
            Navigator.pop(context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 40.0,
            child: Container(
              child: null,
            ),
          ),
        ),
      );
    });
  }
}
