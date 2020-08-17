import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapsheetapp/ui/views/accounts/edit_accounts_order.dart';

class EditAccountsButton extends StatelessWidget {
  const EditAccountsButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      visualDensity: VisualDensity.comfortable,
      minWidth: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.white),
      ),
      child: Icon(
        Icons.list,
        size: 20.0,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.pushNamed(context, EditAccountsOrder.id);
      },
    );
  }
}
