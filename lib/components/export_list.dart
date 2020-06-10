import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/export_tile.dart';
import 'package:snapsheetapp/models/user_data.dart';

class ExportList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userData, child) {
        return ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            final accountTitle = userData.accounts[index].title;
            final isExport = userData.isExport[index];
            return ExportTile(
              accountTitle: accountTitle,
              isExport: isExport,
              checkboxCallback: (checkboxState) {
                userData.toggleExport(index);
                print(userData.isExport.toString());
              },
            );
          },
          itemCount: userData.accountCount,
        );
      },
    );
  }
}
