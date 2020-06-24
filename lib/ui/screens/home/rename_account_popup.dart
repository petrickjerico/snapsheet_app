import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/dashboard_viewmodel.dart';
import 'package:snapsheetapp/ui/config/config.dart';

class RenameAccountPopup extends StatefulWidget {
  static final _formKey = GlobalKey<FormState>();

  @override
  _RenameAccountPopupState createState() => _RenameAccountPopupState();
}

class _RenameAccountPopupState extends State<RenameAccountPopup> {
  Color tempColor;

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            FlatButton(
              child: Text('CANCEL'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text('SUBMIT'),
              onPressed: () {
                final model = Provider.of<DashboardViewModel>(context);
                Navigator.of(context).pop();
                setState(() => model.tempAccount.color = tempColor);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(builder: (context, model, child) {
      return Theme(
        data: ThemeData.light(),
        child: Form(
          key: RenameAccountPopup._formKey,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: model.tempAccount.title,
                      autofocus: true,
                      onChanged: (value) {
                        model.tempAccount.title = value;
                      },
                      decoration: kTextFieldDecorationLogin.copyWith(
                          hintText: 'Rename your account'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    FlatButton(
                      child: Text(
                        'Tap to change colour',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black87,
                            fontSize: 15.0),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      color: model.tempAccount.color,
                      onPressed: () async {
                        _openDialog(
                          "Color your account",
                          MaterialColorPicker(
                            shrinkWrap: true,
                            allowShades: false,
                            onMainColorChange: (newColor) {
                              setState(() {
                                tempColor = newColor;
                              });
                            },
                            selectedColor: model.tempAccount.color,
                          ),
                        );
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 50.0,
                  width: 150.0,
                  child: FlatButton(
                    color: Colors.black,
                    child: Text(
                      'SAVE',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    onPressed: () {
                      if (RenameAccountPopup._formKey.currentState.validate()) {
                        model.updateAccount();
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
