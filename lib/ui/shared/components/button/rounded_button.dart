import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({
    @required this.textColor,
    @required this.color,
    this.title,
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
          visualDensity: VisualDensity.comfortable,
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              icon ?? SizedBox.shrink(),
              icon == null || title == null
                  ? SizedBox.shrink()
                  : SizedBox(width: 10),
              title != null
                  ? Text(
                      title,
                      style: TextStyle(
                        color: textColor,
                      ),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
