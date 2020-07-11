import 'package:flutter/material.dart';

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
        color: Colors.black,
      ),
      onPressed: onPressed,
    );
  }
}
