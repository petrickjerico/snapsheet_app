import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
