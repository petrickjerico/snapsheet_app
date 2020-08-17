import 'package:flutter/material.dart';

class AddRecordFab extends StatelessWidget {
  final onPressed;

  AddRecordFab({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
      onPressed: onPressed,
    );
  }
}
