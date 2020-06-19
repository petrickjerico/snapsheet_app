import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/scanner/receipt_screen.dart';
import 'package:snapsheetapp/models/recordView.dart';

class ReceiptPreview extends StatefulWidget {
  static const String id = 'receipt_preview_screen';

  RecordView recordView;

  ReceiptPreview({this.recordView});

  @override
  _ReceiptPreviewState createState() => _ReceiptPreviewState();
}

class _ReceiptPreviewState extends State<ReceiptPreview> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.recordView,
      child: PageView.builder(
        itemBuilder: (context, position) {
          return ReceiptScreen(recordId: position);
        },
        itemCount: widget.recordView.records.length,
      ),
    );
  }
}
