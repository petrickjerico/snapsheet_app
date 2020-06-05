import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/expenses_calculator.dart';
import 'package:snapsheetapp/components/scanner_button.dart';
import 'package:snapsheetapp/models/record.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:snapsheetapp/screens/editinfo_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:expressions/expressions.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart' as intl;

class AddExpensesScreen extends StatelessWidget {
  static const String id = 'addexpenses_screen';
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userData, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: FlatButton(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              //TODO: more complex navigation
              Navigator.pop(context);
            },
          ),
          title: Text('EXPENSES EDITOR'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, EditInfoScreen.id);
              },
            ),
            ScannerButton(isCamera: true),
            ScannerButton(isCamera: false),
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
