import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/ui/components/date_time.dart';
import 'package:snapsheetapp/ui/components/receipt_image_dialog.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/screens/screens.dart';

class EditExpenseInfoScreen extends StatefulWidget {
  static const String id = 'edit_expense_info_screen';

  const EditExpenseInfoScreen({
    Key key,
  }) : super(key: key);

  @override
  _EditExpenseInfoScreenState createState() => _EditExpenseInfoScreenState();
}

class _EditExpenseInfoScreenState extends State<EditExpenseInfoScreen> {
  String title;
  ExpenseViewModel model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var temp = title;
    model = Provider.of<ExpenseViewModel>(context);
    title = model.tempRecord.title;
    print('Title changed: $temp -> $title');
  }

  @override
  Widget build(BuildContext context) {
    print('EditInfoScreen build() called.');
    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(),
        title: Text('EDIT INFORMATION'),
      ),
      body: Theme(
        data: ThemeData.dark(),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                initialValue: title,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Title",
                ),
                onChanged: (value) {
                  setState(() {
                    model.changeTitle(value);
                  });
                },
              ),
              SizedBox(height: 10.0),
              RecordDateTime(),
              SizedBox(height: 10.0),
              model.tempRecord.imagePath == null
                  ? SizedBox.shrink()
                  : GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (_) => ReceiptImageDialog(
                                File(model.tempRecord.imagePath)));
                      },
                      child: Image.file(
                        File(model.tempRecord.imagePath),
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                    ),
              SizedBox(height: 10),
              RaisedButton(
                padding: EdgeInsets.all(10),
                color: Colors.black,
                child: Text(
                  "Add Receipt",
                  style: kStandardStyle,
                ),
                onPressed: () async {
                  await model.showChoiceDialog(context);
                  model.imageToTempRecord();
                  setState(() {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, EditExpenseInfoScreen.id);
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.check),
        onPressed: () {
          print("Adding to record: \$${model.tempRecord.value}");
          model.addRecord();
          Navigator.popUntil(
            context,
            ModalRoute.withName(HomepageScreen.id),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 40.0,
          child: Container(
            child: null,
          ),
        ),
      ),
    );
//      },
//    );
  }
}
