import 'package:flutter/material.dart';

class ExportTile extends StatelessWidget {
  final bool isExport;
  final String accountTitle;
  final Function checkboxCallback;

  ExportTile({this.isExport, this.accountTitle, this.checkboxCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        accountTitle,
      ),
      trailing: Checkbox(
        activeColor: Colors.black,
        value: isExport,
        onChanged: checkboxCallback,
      ),
    );
  }
}
