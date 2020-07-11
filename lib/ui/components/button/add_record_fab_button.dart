import 'package:flutter/material.dart';
import 'package:snapsheetapp/ui/config/colors.dart';

class AddRecordFab extends StatelessWidget {
  final onPressed;

  AddRecordFab({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.add,
        color: kDarkCyan,
      ),
      onPressed: onPressed,
    );
  }
}
