import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/bulk_scan/bulk_scan_viewmodel.dart';
import 'package:snapsheetapp/ui/components/scanner/receipt_screen.dart';
import 'package:snapsheetapp/ui/config/colors.dart';

class ReceiptPreviewScreen extends StatefulWidget {
  static const String id = 'receipt_preview_screen';

  @override
  _ReceiptPreviewScreenState createState() => _ReceiptPreviewScreenState();
}

class _ReceiptPreviewScreenState extends State<ReceiptPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BulkScanViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Previews"),
          ),
          body: PageView.builder(
            itemBuilder: (context, position) {
              return ReceiptScreen(recordId: position);
            },
            itemCount: model.records.length,
          ),
        );
      },
    );
  }
}
