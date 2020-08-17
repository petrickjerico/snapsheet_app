import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final onPressed;

  CustomBackButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
      onPressed: onPressed ??
          () {
            Navigator.pop(context);
          },
    );
  }
}
