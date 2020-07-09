import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/dashboard_viewmodel.dart';
import 'package:snapsheetapp/ui/components/button/rounded_button.dart';
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
                final model =
                    Provider.of<DashboardViewModel>(context, listen: false);
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
    return Form(
      key: RenameAccountPopup._formKey,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Consumer<DashboardViewModel>(
          builder: (context, model, child) {
            return Column(
              children: <Widget>[
                ListTile(
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: model.tempAccount.color,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: FlatButton(
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
                    ),
                  ),
                  title: TextFormField(
                    initialValue: model.tempAccount.title,
                    cursorColor: Colors.black,
                    autofocus: true,
                    onChanged: (value) {
                      model.tempAccount.title = value;
                    },
                    decoration: kAddAccountTextFieldDecoration.copyWith(
                        hintText: 'Rename your account'),
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
                RoundedButton(
                  color: Colors.black,
                  textColor: Colors.white,
                  title: 'DONE',
                  onPressed: () {
                    if (RenameAccountPopup._formKey.currentState.validate()) {
                      model.updateAccount();
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
