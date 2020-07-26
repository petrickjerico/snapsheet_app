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
        backgroundColor: kBlack,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kBlack,
          leading: BackButton(),
          title: Text('RECORD INFORMATION'),
        ),
        body: Theme(
          data: ThemeData.dark(),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ReceiptImage(tempRecord: model.tempRecord),
                SizedBox(height: 10),
                TextFormField(
                  initialValue: title,
                  cursorColor: Colors.white,
                  decoration: kTitleEditInfoInputDecoration,
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
                color: Colors.blue[300],
              ),
              duration: Duration(seconds: 3),
              leftBarIndicatorColor: Colors.blue[300],
            )..show(context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
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
                      color: Colors.red.withOpacity(0.2),
                      textColor: Colors.white,
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.red,
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
                color: Colors.white,
                textColor: kDarkCyan,
                title: model.hasImage() ? 'Retake Receipt' : 'Add Receipt',
                icon: Icon(Icons.receipt, color: kDarkCyan),
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
                      color: Colors.tealAccent.withOpacity(0.2),
                      textColor: Colors.white,
                      icon: Icon(
                        Icons.cloud_download,
                        color: Colors.tealAccent,
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
    final model = Provider.of<ExpenseViewModel>(context, listen: false);
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
            borderRadius: BorderRadius.circular(8),
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
                    ));
          },
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              MiniLoading(),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: tempRecord.receiptURL,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
