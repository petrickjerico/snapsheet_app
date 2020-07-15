import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/homepage_viewmodel.dart';
import 'package:snapsheetapp/ui/components/button/confirm_record_fab_button.dart';
import 'package:snapsheetapp/ui/config/colors.dart';
import 'package:expressions/expressions.dart';
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
      return WillPopScope(
        onWillPop: () async {
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
          return true;
        },
        child: Scaffold(
          backgroundColor: kBlack,
          appBar: AppBar(
            backgroundColor: kBlack,
            elevation: 0,
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
            title: Text('CALCULATOR'),
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
          floatingActionButton: ConfirmRecordFab(
            onPressed: () {
              bool isEditing = model.isEditing;
              final homepageModel = Provider.of<HomepageViewModel>(
                context,
                listen: false,
              );
              try {
                if (!model.isOperated) {
                  final ExpressionEvaluator evaluator =
                      const ExpressionEvaluator();
                  model.changeValue(
                      evaluator.eval(Expression.parse(model.expression), null));
                }
                model.addRecord();
                homepageModel
                    .selectAccount(model.getAccountIndexFromTempRecord());
                HomepageViewModel.syncController();
                Navigator.pop(context);
                String title = homepageModel.getSelectedAccount().title;
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
              } catch (e) {
                print(e);
                Flushbar(
                  message: "The calculator is experiencing issues.\n"
                      "Tap the equals '=' button and try again.",
                  icon: Icon(
                    Icons.info_outline,
                    size: 28.0,
                    color: Colors.blue[300],
                  ),
                  duration: Duration(seconds: 3),
                  leftBarIndicatorColor: Colors.blue[300],
                )..show(context);
              }
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            notchMargin: 12,
            shape: CircularNotchedRectangle(),
            child: Container(
              height: 56.0,
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
                        HomepageViewModel.syncController();
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
