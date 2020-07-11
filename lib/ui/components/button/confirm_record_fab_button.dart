import 'package:flutter/material.dart';
import 'package:snapsheetapp/ui/config/colors.dart';

class ConfirmRecordFab extends StatelessWidget {
  final onPressed;

  ConfirmRecordFab({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.check,
        color: kDarkCyan,
      ),
      onPressed: onPressed,
    );
  }
}
