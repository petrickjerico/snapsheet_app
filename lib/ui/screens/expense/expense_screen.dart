import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/homepage_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/ui/screens/expense/expense_calculator.dart';
import 'package:flushbar/flushbar.dart';
import 'edit_expense_info_screen.dart';

class ExpenseScreen extends StatefulWidget {
  static const String id = 'expense_screen';

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseViewModel>(builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: BackButton(
            onPressed: () {
              if (model.isEditing) {
                model.undoEditRecord();
              }
              Navigator.pop(context);
              Flushbar(
                message: "Exited calculator. No changes done.",
                icon: Icon(
                  Icons.info_outline,
                  size: 28.0,
                  color: Colors.blue[300],
                ),
                duration: Duration(seconds: 3),
                leftBarIndicatorColor: Colors.blue[300],
              )..show(context);
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
                Navigator.pushNamed(context, EditExpenseInfoScreen.id);
              },
            ),
            IconButton(
              icon: Icon(Icons.receipt),
              onPressed: () async {
                await model.showChoiceDialog(context);
                await model.imageToTempRecord();
                model.toggleScanned();
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                delete();
              },
            ),
          ],
        ),
        body: ExpenseCalculator(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.check),
          onPressed: () {
            final homepageModel = Provider.of<HomepageViewModel>(
              context,
              listen: false,
            );
            model.addRecord();
            homepageModel.selectAccount(model.getAccountIndexFromTempRecord());
            homepageModel.syncController();
            Navigator.pop(context);
            String title = homepageModel.getSelectedAccount().title;
            String messageStatus =
                model.isEditing ? 'updated' : 'added to account: $title';
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

  void delete() {
    showDialog(
      context: context,
      builder: (context) => Consumer<ExpenseViewModel>(
        builder: (context, model, child) => Theme(
          data: ThemeData.light(),
          child: AlertDialog(
            titlePadding: EdgeInsets.only(left: 20, right: 20, top: 20),
            contentPadding:
                EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            title: Text("Delete record?"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Are you sure you want to delete this record?',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        'DELETE',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      onPressed: () {
                        final homepageModel = Provider.of<HomepageViewModel>(
                          context,
                          listen: false,
                        );
                        model.deleteRecord();
                        homepageModel.selectAccount(
                            model.getAccountIndexFromTempRecord());
                        homepageModel.syncController();
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Flushbar(
                          message: "Record successfully deleted.",
                          icon: Icon(
                            Icons.info_outline,
                            size: 28.0,
                            color: Colors.blue[300],
                          ),
                          duration: Duration(seconds: 3),
                          leftBarIndicatorColor: Colors.blue[300],
                        )..show(context);
                      },
                    ),
                    OutlineButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text('NO'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
