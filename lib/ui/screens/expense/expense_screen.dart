import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/dashboard_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/ui/screens/expense/expense_calculator.dart';
import 'package:flushbar/flushbar.dart';
import 'edit_expense_info_screen.dart';

class ExpenseScreen extends StatelessWidget {
  static const String id = 'expense_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseViewModel>(builder: (context, model, child) {
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
        floatingActionButton: Consumer<DashboardViewModel>(
          builder: (context, dashboardModel, child) {
            return FloatingActionButton(
              backgroundColor: Colors.black,
              child: Icon(Icons.check),
              onPressed: () {
                bool isEditing = model.isEditing;
                model.addRecord();
                dashboardModel
                    .selectAccount(model.getAccountIndexFromTempRecord());
                Navigator.pop(context);
                String title = dashboardModel.getSelectedAccount().title;
                String messageStatus =
                    isEditing ? 'updated' : 'added to account: $title';
                Flushbar(
                  message: "Record successfully $messageStatus.",
                  icon: Icon(
                    Icons.info_outline,
                    size: 28.0,
                    color: Colors.blue[300],
                  ),
                  duration: Duration(seconds: 3),
                  leftBarIndicatorColor: Colors.blue[300],
                )..show(context);
              },
            );
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
