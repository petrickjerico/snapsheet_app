import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/homepage_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/ui/screens/expense/expense_screen.dart';

class EmptyState extends StatelessWidget {
  EmptyState(
      {this.onTap,
      this.messageColor,
      @required this.message,
      @required this.icon});

  final Function onTap;
  final Color messageColor;
  final String message;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          child: icon,
          onTap: onTap,
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: messageColor, fontSize: 15),
          ),
        )
      ],
    );
  }
}
