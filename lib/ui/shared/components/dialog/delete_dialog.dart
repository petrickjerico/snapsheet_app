import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  String title;
  String message;
  Function onDelete;

  DeleteDialog({this.title, this.message, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        titlePadding: EdgeInsets.only(left: 20, right: 20, top: 20),
        contentPadding: EdgeInsets.all(20),
        title: Text(title),
        actions: <Widget>[
          OutlineButton(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Text(
              'NO',
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text(
              'YES',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            color: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            onPressed: onDelete,
          ),
        ],
        content: Text(message),
      ),
    );
  }
}
