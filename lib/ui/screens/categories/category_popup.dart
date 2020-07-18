import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/category/category_viewmodel.dart';
import 'package:snapsheetapp/ui/components/button/rounded_button.dart';
import 'package:snapsheetapp/ui/config/decoration.dart';

class CategoryPopUp extends StatefulWidget {
  static final _formKey = GlobalKey<FormState>();

  @override
  _CategoryPopUpState createState() => _CategoryPopUpState();
}

class _CategoryPopUpState extends State<CategoryPopUp> {
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
                    Provider.of<CategoryViewModel>(context, listen: false);
                Navigator.of(context).pop();
                setState(() => model.tempCategory.color = tempColor);
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
      key: CategoryPopUp._formKey,
      child: Container(
        padding:
            EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0, top: 15.0),
        child: Consumer<CategoryViewModel>(
          builder: (context, model, child) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        model.isEditing ? 'Edit Category' : 'Add Category',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.close,
                          size: 25.0,
                          color: Colors.grey,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(right: 2.0),
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: model.tempCategory.color,
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
                            selectedColor: model.tempCategory.color,
                          ),
                        );
                      },
                    ),
                  ),
                  title: TextFormField(
                    initialValue: model.tempCategory.title,
                    cursorColor: Colors.black,
                    autofocus: true,
                    onChanged: (value) {
                      model.tempCategory.title = value;
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
                RoundedButton(
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  color: Colors.black,
                  textColor: Colors.white,
                  title: 'DONE',
                  onPressed: () {
                    if (CategoryPopUp._formKey.currentState.validate()) {
                      model.updateCategory();
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
