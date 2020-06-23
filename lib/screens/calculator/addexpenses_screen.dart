import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/expenses_calculator.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:flutter/rendering.dart';
import 'package:snapsheetapp/services/scanner.dart';

import 'editinfo_screen.dart';

class AddExpensesScreen extends StatelessWidget {
  static const String id = 'addexpenses_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userData, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: BackButton(
            onPressed: () {
              if (userData.isEditing) {
                print('UNDO CALLED');
                userData.undoEditRecord();
              }
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
            IconButton(
              icon: Icon(Icons.receipt),
              onPressed: () async {
                Scanner scanner = Scanner.withUserData(userData);
                await scanner.showChoiceDialog(context);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    print('Loading screen showing...');
                    return Dialog(
                      child: Container(
                        height: 100,
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text('Loading receipt...')
                          ],
                        ),
                      ),
                    );
                  },
                );
                await scanner.process();
                Navigator.pop(context);
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
