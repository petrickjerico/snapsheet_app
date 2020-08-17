import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/bulk_scan/bulk_scan_viewmodel.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/shared/shared.dart';
import 'package:snapsheetapp/ui/views/bulk_scan/receipt_confirmation_button.dart';
import 'package:snapsheetapp/ui/views/screens.dart';

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
                      child: ReceiptConfirmationButton(
                          isConfirmed: model.isConfirmed[recordId],
                          callBack: () {
                            setState(() {
                              model.isConfirmed[recordId] =
                                  !model.isConfirmed[recordId];
                            });
                          }),
                    ),
                  ],
                ),
                RoundedButton(
                  color: kNavyBluePrimary,
                  textColor: Colors.white,
                  title: 'All Receipts Reviewed',
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
            decoration: kFormInputDecoration.copyWith(labelText: "Value"),
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
          decoration: kFormInputDecoration.copyWith(labelText: "Title"),
          cursorColor: Colors.white,
          onChanged: (value) {
            model.changeTitle(recordId, value);
          },
        );
      },
    );
  }
}

class _CategoryFormField extends StatefulWidget {
  final int recordId;

  _CategoryFormField({this.recordId});

  @override
  __CategoryFormFieldState createState() => __CategoryFormFieldState();
}

class __CategoryFormFieldState extends State<_CategoryFormField> {
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
        String categoryUid = model.records[widget.recordId].categoryUid;
        Category category = model.userData.getThisCategory(categoryUid);
        controller.text = category.title;
        return TextFormField(
          controller: controller,
          decoration: kFormInputDecoration.copyWith(labelText: "Category"),
          readOnly: true,
          onTap: () async {
            final newCategoryId = await Navigator.pushNamed(
              context,
              SelectCategoryScreen.id,
            );
            if (newCategoryId != null) {
              model.changeCategory(widget.recordId, newCategoryId);
            }
          },
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
            decoration: kFormInputDecoration.copyWith(labelText: "Date"),
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
