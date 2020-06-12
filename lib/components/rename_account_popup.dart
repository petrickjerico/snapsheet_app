import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/constants.dart';
import 'package:snapsheetapp/models/account.dart';
import 'package:snapsheetapp/models/user_data.dart';

class RenameAccountPopup extends StatefulWidget {
  RenameAccountPopup(this.id);
  int id;
  static final _formKey = GlobalKey<FormState>();

  @override
  _RenameAccountPopupState createState() => _RenameAccountPopupState();
}

class _RenameAccountPopupState extends State<RenameAccountPopup> {
  String accountTitle;

  Color color;
  Color tempColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Account acc = Provider.of<UserData>(context).accounts[widget.id];
    color = acc.color;
    accountTitle = acc.title;
  }

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
                setState(() => color = tempColor);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userData, child) {
      return Form(
        key: RenameAccountPopup._formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: accountTitle,
                    autofocus: true,
                    onChanged: (value) {
                      accountTitle = value;
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
                  Row(
                    children: <Widget>[
                      Text('Color:'),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: FlatButton(
                          child: Text(
                            'Tap to change',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.black54,
                                fontSize: 10.0),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          color: color,
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
                                selectedColor: color,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
                      userData.editAccount(widget.id, accountTitle, color);
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
      );
    });
  }
}
