import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/bulk_scan/bulk_scan_viewmodel.dart';
import 'package:snapsheetapp/ui/components/button/delete_button.dart';
import 'package:snapsheetapp/ui/components/button/rounded_button.dart';
import 'package:snapsheetapp/ui/components/receipt_image_dialog.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/screens/screens.dart';

class ReceiptScreen extends StatefulWidget {
  final int recordId;

  ReceiptScreen({this.recordId});

  @override
  _ReceiptScreenState createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  int recordId;

  @override
  void initState() {
    super.initState();
    recordId = widget.recordId;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BulkScanViewModel>(
      builder: (context, model, child) {
        Record record = model.records[recordId];
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: kBlack,
          body: SingleChildScrollView(
            child: Theme(
              data: ThemeData.dark(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (_) => ReceiptImageDialog(record.image));
                      },
                      child: Image.file(
                        record.image,
                        fit: BoxFit.fitWidth,
                        height: 200,
                        width: 800,
                      ),
                    ),
                    SizedBox(height: 30),
                    // Value + Title
                    TextFormField(
                      initialValue: record.title,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Title",
                      ),
                      onChanged: (value) {
                        setState(() {
                          model.records[recordId].title = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      initialValue: record.value.toString(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Value",
                      ),
                      onChanged: (value) {
                        setState(() {
                          model.records[recordId].value = double.parse(value);
                        });
                      },
                    ),
                    DeleteConfirmButton(
                        isDelete: model.isDelete[recordId],
                        callBack: () {
                          setState(() {
                            model.isDelete[recordId] =
                                !model.isDelete[recordId];
                          });
                        }),
                    RoundedButton(
                      color: Colors.white,
                      textColor: kBlack,
                      title: 'Confirm All Receipts',
                      icon: Icon(Icons.done_all, color: kBlack),
                      onPressed: () {
                        model.addAll();
                        Navigator.pushNamed(context, HomepageScreen.id);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
