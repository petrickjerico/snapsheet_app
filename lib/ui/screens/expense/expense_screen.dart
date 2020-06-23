import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';

import 'edit_expense_info_screen.dart';

class ExpenseScreen extends StatelessWidget {
  static const String id = 'expense_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userData, child) {
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
                Scanner scanner = Scanner.withUserData(userData);
                await scanner.showChoiceDialog(context);
                scanner.process();
              },
            )
          ],
        ),
        body: ExpensesCalculator(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.check),
          onPressed: () {
            userData.addRecord();
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
