import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/export/export_viewmodel.dart';
import 'package:snapsheetapp/ui/views/export/export_tile.dart';

class ExportList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExportViewModel>(
      builder: (context, model, child) {
        return ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            final account = model.accounts[index];
            final isExport = model.isExport[index];
            return ExportTile(
              account: account,
              isExport: isExport,
              voidCallback: () {
                model.toggleExport(index);
              },
            );
          },
          itemCount: model.accounts.length,
        );
      },
    );
  }
}
