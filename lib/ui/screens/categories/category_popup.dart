import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/category/category_viewmodel.dart';
import 'package:snapsheetapp/ui/components/button/rounded_button.dart';
import 'package:snapsheetapp/ui/config/decoration.dart';

class CategoryPopUp extends StatefulWidget {
  static final _formKey = GlobalKey<FormState>();

  @override
  _CategoryPopUpState createState() => _CategoryPopUpState();
}

class _CategoryPopUpState extends State<CategoryPopUp> {
  Color _tempColor;
  Icon _icon;

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
                setState(() => model.tempCategory.color = _tempColor);
              },
            ),
          ],
        );
      },
    );
  }

  void _pickIcon() async {
    IconData pickedIcon = await FlutterIconPicker.showIconPicker(
      context,
      adaptiveDialog: true,
      iconPickerShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      iconPackMode: IconPack.fontAwesomeIcons,
    );

    if (pickedIcon != null) {
      _icon = Icon(pickedIcon);
      final model = Provider.of<CategoryViewModel>(context, listen: false);
      setState(() => model.changeIcon(_icon));
    }
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
            Category tempCategory = model.tempCategory;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 40,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: model.tempCategory.color,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Icon(Icons.edit),
                        ),
                        onPressed: () async {
                          _openDialog(
                            "Color your category",
                            MaterialColorPicker(
                              shrinkWrap: true,
                              allowShades: false,
                              onMainColorChange: (newColor) {
                                setState(() {
                                  _tempColor = newColor;
                                });
                              },
                              selectedColor: tempCategory.color,
                            ),
                          );
                        },
                      ),
                    ),
                    FlatButton(
                      child: CircleAvatar(
                        backgroundColor: tempCategory.color.withOpacity(0.2),
                        child: IconTheme(
                          data: IconThemeData(
                              color: tempCategory.color, size: 18),
                          child: tempCategory.icon,
                        ),
                      ),
                      onPressed: _pickIcon,
                    ),
                    FlatButton(
                      child: Text(tempCategory.isIncome ? 'INCOME' : 'EXPENSE'),
                      color: tempCategory.isIncome
                          ? Colors.teal.withOpacity(0.2)
                          : Colors.redAccent.withOpacity(0.2),
                      textColor: tempCategory.isIncome
                          ? Colors.teal
                          : Colors.redAccent,
                      onPressed: () {
                        model.changeIsIncome();
                        setState(() {});
                      },
                    )
                  ],
                ),
                TextFormField(
                  initialValue: model.tempCategory.title,
                  cursorColor: Colors.black,
                  autofocus: true,
                  onChanged: (value) {
                    model.tempCategory.title = value;
                  },
                  decoration: kAddAccountTextFieldDecoration.copyWith(
                      hintText: 'Category Name'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text.';
                    }
                    return null;
                  },
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
                      model.addCategory();
                      if (model.showDefault) model.toggleView();
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
