import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/dashboard_viewmodel.dart';
import 'package:snapsheetapp/ui/config/config.dart';

class AddAccountPopup extends StatefulWidget {
  static final _formKey = GlobalKey<FormState>();

  @override
  _AddAccountPopupState createState() => _AddAccountPopupState();
}

class _AddAccountPopupState extends State<AddAccountPopup> {
  String accountTitle;

  Color _color = kCyan;
  Color _tempColor;

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
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
                Navigator.of(context).pop();
                setState(() => _color = _tempColor);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: AddAccountPopup._formKey,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 10.0),
                TextFormField(
                  autofocus: true,
                  onChanged: (value) {
                    accountTitle = value;
                  },
                  decoration: kTextFieldDecorationLogin.copyWith(
                      hintText: 'Name your new account'),
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
                  color: _color,
                  onPressed: () async {
                    _openDialog(
                      "Color your account",
                      MaterialColorPicker(
                        shrinkWrap: true,
                        allowShades: false,
                        onMainColorChange: (newColor) {
                          setState(() {
                            _tempColor = newColor;
                          });
                        },
                        selectedColor: _color,
                      ),
                    );
                  },
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Consumer<DashboardViewModel>(builder: (context, model, child) {
              return Container(
                height: 50.0,
                width: 150.0,
                child: FlatButton(
                  color: Colors.black,
                  child: Text(
                    'CREATE',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  onPressed: () {
                    if (AddAccountPopup._formKey.currentState.validate()) {
                      print(accountTitle);
                      print(_color.toString());
                      model.addAccount(accountTitle, _color);
                      model.selectAccount(model.accounts.length);
                      Navigator.pop(context);
                    }
                  },
                ),
              );
            }),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
