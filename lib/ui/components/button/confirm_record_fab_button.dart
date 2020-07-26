import 'package:flutter/material.dart';
import 'package:snapsheetapp/ui/config/colors.dart';

class ConfirmRecordFab extends StatelessWidget {
  final onPressed;

  ConfirmRecordFab({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 10.0,
      backgroundColor: kNavyBlue,
      child: Icon(
        Icons.check,
      ),
      onPressed: onPressed,
    );
  }
}
