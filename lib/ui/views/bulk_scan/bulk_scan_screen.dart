import 'package:flutter/material.dart';
import 'package:snapsheetapp/ui/views/bulk_scan/bulk_scan_accounts_list.dart';

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
