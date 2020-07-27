import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/homepage_viewmodel.dart';
import 'package:snapsheetapp/ui/components/button/confirm_record_fab_button.dart';
import 'package:snapsheetapp/ui/components/button/rounded_button.dart';
import 'package:snapsheetapp/ui/components/date_time.dart';
import 'package:snapsheetapp/ui/components/dialog/delete_dialog.dart';
import 'package:snapsheetapp/ui/components/receipt_image_dialog.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/shared/shared.dart';
import 'package:transparent_image/transparent_image.dart';

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
    model = Provider.of<ExpenseViewModel>(context);
    title = model.tempRecord.title;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unfocus(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('RECORD INFORMATION'),
          backgroundColor: Colors.transparent,
          textTheme: Theme.of(context).textTheme,
          iconTheme: Theme.of(context).iconTheme,
          elevation: 0,
          leading: BackButton(),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ReceiptImage(tempRecord: model.tempRecord),
              SizedBox(height: 10),
              TextFormField(
                initialValue: title,
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
                  setState(() {
                    model.changeTitle(value);
                  });
                },
              ),
              SizedBox(height: 10.0),
              RecordDateTime(),
              SizedBox(height: 10.0),
              ReceiptButtons(),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom / 4)),
            ],
          ),
        ),
        floatingActionButton: ConfirmRecordFab(
          onPressed: () {
            final homepageModel =
                Provider.of<HomepageViewModel>(context, listen: false);
            model.addRecord();
            bool isEditing = model.isEditing;
            homepageModel.selectAccount(model.getAccountIndexFromTempRecord());
            HomepageViewModel.syncController();
            Navigator.pop(context);
            Navigator.pop(context);
            String title = homepageModel.getSelectedAccount().title;
            String messageStatus =
                isEditing ? 'updated' : 'added to account: $title';
            Flushbar(
              message: "Record successfully $messageStatus.",
              icon: Icon(
                Icons.info_outline,
                size: 28.0,
                color: Theme.of(context).colorScheme.secondary,
              ),
              duration: Duration(seconds: 3),
              leftBarIndicatorColor: Theme.of(context).colorScheme.secondary,
            )..show(context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).colorScheme.primaryVariant,
          notchMargin: 12,
          shape: CircularNotchedRectangle(),
          child: Container(height: 56.0, child: null),
        ),
      ),
    );
  }
}

class ReceiptButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseViewModel>(
      builder: (context, model, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            model.hasImage()
                ? Expanded(
                    flex: 1,
                    child: RoundedButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                      ),
                      onPressed: () => showDialog(
                        context: context,
                        child: DeleteDialog(
                            title: 'Delete Image',
                            message:
                                'Are you sure you want to delete the image?',
                            onDelete: () {
                              model.deleteImage();
                              Navigator.pop(context);
                            }),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            model.hasImage() ? SizedBox(width: 20) : SizedBox.shrink(),
            Expanded(
              flex: 2,
              child: RoundedButton(
                color: kNavyBluePrimary,
                title: model.hasImage() ? 'Retake Receipt' : 'Add Receipt',
                textColor: Colors.white,
                icon: Icon(
                  Icons.receipt,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await model.showChoiceDialog(context);
                  model.imageToTempRecord();
                },
              ),
            ),
            model.hasImage() ? SizedBox(width: 20) : SizedBox.shrink(),
            model.hasImage()
                ? Expanded(
                    flex: 1,
                    child: RoundedButton(
                      color: Colors.teal,
                      textColor: Colors.white,
                      icon: Icon(
                        Icons.cloud_download,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        await model.exportImage();
                      },
                    ),
                  )
                : SizedBox.shrink()
          ],
        );
      },
    );
  }
}

class ReceiptImage extends StatelessWidget {
  Record tempRecord;

  ReceiptImage({this.tempRecord});
  @override
  Widget build(BuildContext context) {
    if (tempRecord.imagePath != null) {
      return Expanded(
        child: GestureDetector(
          onTap: () async {
            await showDialog(
                context: context,
                builder: (_) =>
                    ReceiptImageDialog(imagePath: tempRecord.imagePath));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Image.file(
              File(tempRecord.imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else if (tempRecord.receiptURL != null) {
      return Expanded(
        child: GestureDetector(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (_) => ReceiptImageDialog(
                receiptURL: tempRecord.receiptURL,
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            clipBehavior: Clip.antiAlias,
            child: Container(
              color: kLightBlueBackground,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  MiniLoading(),
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: tempRecord.receiptURL,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
