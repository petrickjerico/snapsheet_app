import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "${recordId + 1} / ${model.records.length}",
                        style: TextStyle(fontSize: 18),
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
                        Expanded(child: _CategoryFormField(recordId: recordId)),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: DeleteConfirmButton(
                          isDelete: model.isDelete[recordId],
                          callBack: () {
                            setState(() {
                              model.isDelete[recordId] =
                                  !model.isDelete[recordId];
                            });
                          }),
                    ),
                  ],
                ),
                RoundedButton(
                  color: kNavyBluePrimary,
                  textColor: Colors.white,
                  title: 'Confirm All Receipts',
                  icon: Icon(Icons.done_all, color: Colors.white),
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
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(3.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(3.0)),
              labelText: "Value",
              labelStyle: TextStyle(color: Colors.grey),
            ),
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
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(3.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(3.0)),
            labelText: "Title",
            labelStyle: TextStyle(color: Colors.grey),
          ),
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
        String categoryUid = model.records[recordId].categoryUid;
        Category category = model.userData.getThisCategory(categoryUid);
        return PopupMenuButton(
          captureInheritedThemes: false,
          key: _menuKey,
          initialValue: category.index,
          onSelected: (input) {
            model.changeCategory(recordId, input);
          },
          itemBuilder: (context) {
            return model.userData.categories
                .map(
                  (category) => PopupMenuItem(
                    value: model.userData.categories.indexOf(category),
                    child: ListTile(
                      leading: category.icon,
                      title: Text(category.title),
                    ),
                  ),
                )
                .toList();
          },
          child: TextFormField(
            initialValue: category.title,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(3.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(3.0)),
              labelText: "Category",
              labelStyle: TextStyle(color: Colors.grey),
            ),
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

class _DateFormField extends StatefulWidget {
  final int recordId;

  _DateFormField({this.recordId});

  @override
  __DateFormFieldState createState() => __DateFormFieldState();
}

class __DateFormFieldState extends State<_DateFormField> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BulkScanViewModel>(
      builder: (context, model, child) {
        DateTime date = model.records[widget.recordId].dateTime;
        controller.text = DateFormat.yMMMd().format(date);
        return TextFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(3.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(3.0)),
              labelText: "Date",
              labelStyle: TextStyle(color: Colors.grey),
            ),
            readOnly: true,
            controller: controller,
            onTap: () async {
              DateTime picked = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(date.year - 5),
                lastDate: DateTime(date.year + 5),
              );
              if (picked != null) {
                model.changeDate(widget.recordId, picked);
              }
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
