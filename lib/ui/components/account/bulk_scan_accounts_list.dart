import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/bulk_scan/bulk_scan_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';

class BulkScanAccountsList extends StatefulWidget {
  @override
  _BulkScanAccountsListState createState() => _BulkScanAccountsListState();
}

class _BulkScanAccountsListState extends State<BulkScanAccountsList> {
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context, listen: false);
    return ChangeNotifierProvider<BulkScanViewModel>(
      create: (context) => BulkScanViewModel(userData: userData),
      child: Consumer<BulkScanViewModel>(
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
                      await model.loadAssets();
                      if (model.assets != null) {
                        setState(() {
                          showSpinner = true;
                        });
                        RecordView recordView = RecordView(
                            id: index, assets: assets, userData: userData);
                        print('recordView');
                        await recordView.initialize();
                        print('INITIALIZED');
                        setState(() {
                          showSpinner = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReceiptPreview(
                                      recordView: recordView,
                                    )));
                      }
                    },
                  ),
                );
              },
              itemCount: userData.accounts.length,
            ),
          );
        },
      ),
    );
  }
}
