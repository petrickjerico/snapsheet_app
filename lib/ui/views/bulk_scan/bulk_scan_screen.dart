import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/bulk_scan/bulk_scan_viewmodel.dart';
import 'file:///C:/Users/jtedd/AndroidStudioProjects/snapsheet_app/lib/business_logic/view_models/user_data/user_data_impl.dart';
import 'file:///C:/Users/jtedd/AndroidStudioProjects/snapsheet_app/lib/ui/views/bulk_scan/bulk_scan_accounts_list.dart';

class BulkScanScreen extends StatelessWidget {
  static const String id = 'bulkscan_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(),
        textTheme: Theme.of(context).textTheme,
        iconTheme: Theme.of(context).iconTheme,
        title: Text('Select Account to Upload Receipts'),
      ),
      body: BulkScanAccountsList(),
    );
  }
}
