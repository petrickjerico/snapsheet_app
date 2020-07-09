import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/dashboard_viewmodel.dart';
import 'package:snapsheetapp/ui/components/button/rounded_button.dart';
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
            ListTile(
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: _color, borderRadius: BorderRadius.circular(5.0)),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
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
                ),
              ),
              title: TextFormField(
                autofocus: true,
                onChanged: (value) {
                  accountTitle = value;
                },
                cursorColor: Colors.black,
                decoration: kAddAccountTextFieldDecoration,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text.';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Consumer<DashboardViewModel>(builder: (context, model, child) {
              return RoundedButton(
                color: Colors.black,
                textColor: Colors.white,
                title: 'CREATE',
                onPressed: () {
                  if (AddAccountPopup._formKey.currentState.validate()) {
                    model.selectAccount(model.accounts.length);
                    model.addAccount(accountTitle, _color);
                    model.syncController();
                    Navigator.pop(context);
                  }
                },
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
