import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/export_tile.dart';
import 'package:snapsheetapp/models/export.dart';
import 'package:snapsheetapp/models/user_data.dart';

class ExportList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userData, child) {
        Exporter exporter = userData.exporter;
        return ListView.separated(
          padding: EdgeInsets.all(12),
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            final accountTitle = exporter.accounts[index].title;
            final isExport = exporter.isExport[index];
            return ExportTile(
              accountTitle: accountTitle,
              isExport: isExport,
              checkboxCallback: (checkboxState) {
                userData.toggleExport(index);
                print(exporter.isExport.toString());
              },
            );
          },
          itemCount: exporter.accountCount,
        );
      },
    );
  }
}
