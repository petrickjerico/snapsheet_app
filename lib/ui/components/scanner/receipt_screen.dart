import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/bulk_scan/bulk_scan_viewmodel.dart';
import 'package:snapsheetapp/ui/components/button/delete_button.dart';
import 'package:snapsheetapp/ui/components/button/rounded_button.dart';
import 'package:snapsheetapp/ui/components/receipt_image_dialog.dart';
import 'package:snapsheetapp/ui/config/config.dart';

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
        return GestureDetector(
          onTap: () => unfocus(context),
          child: Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: kBlack,
            body: SingleChildScrollView(
              child: Theme(
                data: ThemeData.dark(),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "${recordId + 1} / ${model.records.length}",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      ReceiptImage(imagePath: record.imagePath),
                      SizedBox(height: 30),
                      // Value + Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: _ValueFormField(recordId: recordId),
                          ),
                          SizedBox(width: 15),
                          Flexible(
                            flex: 4,
                            child: _TitleFormField(recordId: recordId),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(child: _DateFormField(recordId: recordId)),
                          SizedBox(width: 15),
                          Expanded(
                              child: _CategoryFormField(recordId: recordId)),
                        ],
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
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ValueFormField extends StatelessWidget {
  final int recordId;

  _ValueFormField({this.recordId});

  @override
  Widget build(BuildContext context) {
    return Consumer<BulkScanViewModel>(
      builder: (context, model, child) {
        return TextFormField(
            initialValue: model.records[recordId].value.toStringAsFixed(2),
            keyboardType: TextInputType.number,
            cursorColor: Colors.white,
            decoration:
                kTitleEditInfoInputDecoration.copyWith(labelText: 'Value'),
            onChanged: (value) {
              model.changeValue(recordId, double.parse(value));
            });
      },
    );
  }
}

class _TitleFormField extends StatelessWidget {
  final int recordId;

  _TitleFormField({this.recordId});

  @override
  Widget build(BuildContext context) {
    return Consumer<BulkScanViewModel>(
      builder: (context, model, child) {
        return TextFormField(
          initialValue: model.records[recordId].title,
          decoration: kTitleEditInfoInputDecoration,
          cursorColor: Colors.white,
          onChanged: (value) {
            model.changeTitle(recordId, value);
          },
        );
      },
    );
  }
}

class _CategoryFormField extends StatelessWidget {
  final int recordId;
  final GlobalKey _menuKey = GlobalKey();

  _CategoryFormField({this.recordId});

  @override
  Widget build(BuildContext context) {
    return Consumer<BulkScanViewModel>(
      builder: (context, model, child) {
        int categoryId = model.records[recordId].categoryId;
        return PopupMenuButton(
          key: _menuKey,
          initialValue: categoryId,
          onSelected: (input) {
            model.changeCategory(recordId, input);
          },
          itemBuilder: (context) {
            List<String> categoryTitles =
                categories.map((category) => category.title).toList();
            return categoryTitles
                .map(
                  (e) => PopupMenuItem(
                    value: categoryTitles.indexOf(e),
                    child: ListTile(
                      leading: categories[categoryTitles.indexOf(e)].icon,
                      title: Text(e),
                    ),
                  ),
                )
                .toList();
          },
          child: TextFormField(
            initialValue: categories[categoryId].title,
            decoration:
                kTitleEditInfoInputDecoration.copyWith(labelText: 'Category'),
            readOnly: true,
            onTap: () {
              dynamic state = _menuKey.currentState;
              state.showButtonMenu();
            },
          ),
        );
      },
    );
  }
}

class _DateFormField extends StatelessWidget {
  final int recordId;

  _DateFormField({this.recordId});

  @override
  Widget build(BuildContext context) {
    return Consumer<BulkScanViewModel>(
      builder: (context, model, child) {
        DateTime date = model.records[recordId].dateTime;
        return TextFormField(
            initialValue: DateFormat.yMMMd().format(date),
            decoration:
                kTitleEditInfoInputDecoration.copyWith(labelText: 'Date'),
            readOnly: true,
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(date.year - 5),
                lastDate: DateTime(date.year + 5),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.dark(),
                    child: child,
                  );
                },
              ).then((value) {
                model.changeDate(
                    recordId,
                    DateTime(
                      value.year,
                      value.month,
                      value.day,
                    ));
              });
            });
      },
    );
  }
}

class ReceiptImage extends StatelessWidget {
  String imagePath;

  ReceiptImage({this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showDialog(
            context: context,
            builder: (_) => ReceiptImageDialog(imagePath: imagePath));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(imagePath),
          fit: BoxFit.fitWidth,
          width: 800,
          height: 200,
        ),
      ),
    );
  }
}
