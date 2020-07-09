import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({
    @required this.textColor,
    @required this.color,
    @required this.title,
    @required this.onPressed,
    this.icon,
  });

  final Icon icon;
  final Color textColor;
  final Color color;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 2.0,
        color: color,
        borderRadius: BorderRadius.circular(15.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon ?? SizedBox.shrink(),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
