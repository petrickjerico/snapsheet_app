import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/expenses_calculator.dart';
import 'package:snapsheetapp/models/scanner.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:snapsheetapp/screens/editinfo_screen.dart';
import 'package:flutter/rendering.dart';

class AddExpensesScreen extends StatelessWidget {
  static const String id = 'addexpenses_screen';
  ValueNotifier<bool> buttonTrigger = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userData, child) {
      return ChangeNotifierProvider<ValueNotifier<bool>>(
        create: (context) => buttonTrigger,
        child: Scaffold(
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
                  Navigator.pushNamed(context, EditInfoScreen.id);
                },
              ),
              IconButton(
                icon: Icon(Icons.receipt),
                onPressed: () async {
                  Scanner scanner = Scanner(userData);
                  await scanner.showChoiceDialog(context);
                  scanner.process();
                },
              )
            ],
          ),
          body: ExpensesCalculator(),
          floatingActionButton: CheckEqualsFab(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
        ),
      );
    });
  }
}

class CheckEqualsFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ValueNotifier<bool>>(
      builder: (context, buttonTrigger, child) => FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.check),
        onPressed: () async {
          if (buttonTrigger.value == true) {
            Provider.of<UserData>(context, listen: false).addRecord();
            Navigator.pop(context);
          } else {
            buttonTrigger.value = true;
            Provider.of<UserData>(context, listen: false).addRecord();
            await Future.delayed(Duration(milliseconds: 700));
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
