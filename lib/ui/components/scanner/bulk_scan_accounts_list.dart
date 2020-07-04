import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/bulk_scan/bulk_scan_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/ui/components/scanner/receipt_preview.dart';

class BulkScanAccountsList extends StatefulWidget {
  @override
  _BulkScanAccountsListState createState() => _BulkScanAccountsListState();
}

class _BulkScanAccountsListState extends State<BulkScanAccountsList> {
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<BulkScanViewModel>(
      builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: ListView.separated(
            padding: EdgeInsets.all(12),
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final account = model.accounts[index];
              return Card(
                color: account.color,
                child: ListTile(
                  title: Text(
                    account.title,
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    model.selectedAccountUid = account.uid;
                    await model.loadAssets();
                    if (model.assets != null) {
                      setState(() => showSpinner = true);
                      await model.initialize();
                      setState(() => showSpinner = false);
                      Navigator.pushNamed(context, ReceiptPreviewScreen.id);
                    }
                  },
                ),
              );
            },
            itemCount: model.accounts.length,
          ),
        );
      },
    );
  }
}
