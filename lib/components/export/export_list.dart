import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/export/export_tile.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:snapsheetapp/services/export.dart';

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
            final account = exporter.accounts[index];
            final isExport = exporter.isExport[index];
            return ExportTile(
              account: account,
              isExport: isExport,
              voidCallback: () {
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