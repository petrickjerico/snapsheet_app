import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/button/delete_button.dart';
import 'package:snapsheetapp/components/button/rounded_button.dart';
import 'package:snapsheetapp/components/receipt_image_dialog.dart';
import 'package:snapsheetapp/config/config.dart';
import 'package:snapsheetapp/models/record.dart';
import 'package:snapsheetapp/models/recordView.dart';
import 'package:snapsheetapp/models/user.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:snapsheetapp/screens/authentication/welcome_screen.dart';
import 'package:snapsheetapp/screens/home/homepage_screen.dart';

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
    return Consumer<RecordView>(
      builder: (context, recordView, child) {
        UserData userData = Provider.of<UserData>(context);
        Record record = recordView.records[recordId];
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
                          recordView.records[recordId].title = value;
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
                          recordView.records[recordId].value =
                              double.parse(value);
                        });
                      },
                    ),
                    DeleteConfirmButton(
                        isDelete: record.toDelete,
                        callBack: () {
                          setState(() {
                            recordView.records[recordId].toDelete =
                                !recordView.records[recordId].toDelete;
                          });
                        }),
                    RoundedButton(
                      color: Colors.white,
                      textColor: kBlack,
                      title: 'Confirm All Receipts',
                      icon: Icon(Icons.done_all, color: kBlack),
                      onPressed: () {
                        recordView.addAll();
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
