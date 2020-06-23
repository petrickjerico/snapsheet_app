import 'package:flutter/material.dart';
import 'package:snapsheetapp/business_logic/models/account.dart';

class ExportTile extends StatelessWidget {
  final bool isExport;
  final Account account;
  final Function voidCallback;

  ExportTile({this.isExport, this.account, this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isExport ? account.color : Colors.grey,
      child: ListTile(
        onTap: voidCallback,
        title: Text(
          account.title,
          style: TextStyle(color: isExport ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
