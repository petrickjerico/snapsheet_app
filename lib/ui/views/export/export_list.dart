import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/export/export_viewmodel.dart';
import 'file:///C:/Users/jtedd/AndroidStudioProjects/snapsheet_app/lib/business_logic/view_models/user_data/user_data_impl.dart';
import 'file:///C:/Users/jtedd/AndroidStudioProjects/snapsheet_app/lib/ui/views/export/export_tile.dart';

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
