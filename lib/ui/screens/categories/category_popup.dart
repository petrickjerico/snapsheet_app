import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                Header(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: tempCategory.color.withOpacity(0.2),
                      child: IconTheme(
                        data:
                            IconThemeData(color: tempCategory.color, size: 36),
                        child: FaIcon(tempCategory.icon.icon),
                      ),
                    ),
                    SizedBox(width: 14),
                    Flexible(
                      flex: 1,
                      child: TextFormField(
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
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    ColorPicker(),
                    IconPicker(),
                    SizedBox(width: 14),
                    Expanded(child: IncomeExpenseToggle())
                  ],
                ),
                RoundedButton(
                  icon: Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  color: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).colorScheme.onPrimary,
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

class IconMaker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CategoryViewModel>(context);
    Category tempCategory = model.tempCategory;
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: tempCategory.color.withOpacity(0.2),
          child: IconTheme(
            data: IconThemeData(color: tempCategory.color, size: 36),
            child: FaIcon(tempCategory.icon.icon),
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            ColorPicker(),
            IconPicker(),
          ],
        )
      ],
    );
  }
}

class ColorPicker extends StatefulWidget {
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color _tempColor;

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          contentPadding: EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            OutlineButton(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              child: Text('CANCEL'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              color: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
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

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CategoryViewModel>(context);
    return Container(
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
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
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
              selectedColor: model.tempCategory.color,
            ),
          );
        },
      ),
    );
  }
}

class IconPicker extends StatefulWidget {
  @override
  _IconPickerState createState() => _IconPickerState();
}

class _IconPickerState extends State<IconPicker> {
  Icon _icon;

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
    final model = Provider.of<CategoryViewModel>(context);
    return Container(
      width: 40,
      height: 40,
      child: FlatButton(
        padding: EdgeInsets.all(0),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Container(
          width: 40,
          height: 40,
          child: IconTheme(
            data: IconThemeData(color: model.tempCategory.color, size: 18),
            child: model.tempCategory.icon,
          ),
        ),
        onPressed: _pickIcon,
      ),
    );
  }
}

class IncomeExpenseToggle extends StatefulWidget {
  @override
  _IncomeExpenseToggleState createState() => _IncomeExpenseToggleState();
}

class _IncomeExpenseToggleState extends State<IncomeExpenseToggle> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CategoryViewModel>(context);
    Category tempCategory = model.tempCategory;
    return FlatButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.touch_app, size: 18),
          SizedBox(width: 12),
          Text(tempCategory.isIncome ? 'INCOME' : 'EXPENSE'),
        ],
      ),
      color: tempCategory.isIncome
          ? Colors.teal.withOpacity(0.2)
          : Colors.redAccent.withOpacity(0.2),
      textColor: tempCategory.isIncome ? Colors.teal : Colors.redAccent,
      onPressed: () {
        model.changeIsIncome();
        setState(() {});
      },
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CategoryViewModel>(context, listen: false);
    return Padding(
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
    );
  }
}
