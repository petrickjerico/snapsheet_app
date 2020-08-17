import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/default_data/default_data.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/recurring/recurring_viewmodel.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/shared/shared.dart';
import 'package:snapsheetapp/ui/views/screens.dart';

class AddRecurringScreen extends StatefulWidget {
  static const String id = "add_recurring_screen";

  @override
  _AddRecurringScreenState createState() => _AddRecurringScreenState();
}

class _AddRecurringScreenState extends State<AddRecurringScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecurringViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        textTheme: Theme.of(context).textTheme,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            if (model.isEditing) {
              model.undo();
            }
            Navigator.pop(context);
          },
        ),
        title: Text('Add Recurring Expense'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                  context: context,
                  child: DeleteDialog(
                    title: 'Delete Recurring Expense',
                    message:
                        'Are you sure you want to delete this recurring expense?',
                    onDelete: () {
                      model.deleteRecurring();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _TitleFormField(),
                SizedBox(height: 10),
                _ValueFormField(),
                SizedBox(height: 10),
                _CategoryFormField(),
                SizedBox(height: 10),
                _AccountFormField(),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                _NextRecurrenceFormField(),
                SizedBox(height: 10),
                _FrequencyFormField(),
                SizedBox(height: 10),
                _TimeFrameFormField(),
                SizedBox(height: 10),
                _TimeFrameHelperFormField(),
                RoundedButton(
                  textColor: Colors.white,
                  color: kNavyBluePrimary,
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  title: "Confirm",
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      model.addRecurring();
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        return TextFormField(
          initialValue: model.tempRecurring.title,
          validator: (title) => title.isEmpty ? "Please input a title" : null,
          decoration: kFormInputDecoration.copyWith(labelText: 'Title'),
          cursorColor: kNavyBluePrimary,
          onChanged: (value) {
            model.changeTitle(value);
          },
        );
      },
    );
  }
}

class _ValueFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        return TextFormField(
            initialValue: model.tempRecurring.value.toStringAsFixed(2),
            validator: (value) => double.parse(value) <= 0
                ? "Please input a positive number"
                : null,
            keyboardType: TextInputType.number,
            decoration: kFormInputDecoration.copyWith(labelText: 'Value'),
            onChanged: (value) {
              model.changeValue(double.parse(value));
            });
      },
    );
  }
}

class _CategoryFormField extends StatefulWidget {
  @override
  __CategoryFormFieldState createState() => __CategoryFormFieldState();
}

class __CategoryFormFieldState extends State<_CategoryFormField> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        String categoryUid = model.tempRecurring.categoryUid;
        Category category = model.userData.getThisCategory(categoryUid);
        controller.text = category.title;
        return TextFormField(
          controller: controller,
          decoration: kFormInputDecoration.copyWith(labelText: 'Category'),
          readOnly: true,
          onTap: () async {
            final newCategoryId = await Navigator.pushNamed(
              context,
              SelectCategoryScreen.id,
            );
            if (newCategoryId != null) {
              model.changeCategory(newCategoryId);
            }
          },
        );
      },
    );
  }
}

class _AccountFormField extends StatefulWidget {
  @override
  __AccountFormFieldState createState() => __AccountFormFieldState();
}

class __AccountFormFieldState extends State<_AccountFormField> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        String accountUid = model.tempRecurring.accountUid;
        Account account = model.getAccountFromUid(accountUid);
        controller.text = account.title;
        return TextFormField(
          controller: controller,
          decoration: kFormInputDecoration.copyWith(labelText: 'Account'),
          readOnly: true,
          onTap: () async {
            final newAccountId =
                await Navigator.pushNamed(context, SelectAccountScreen.id);
            if (newAccountId != null) {
              model.changeAccount(newAccountId);
            }
          },
        );
      },
    );
  }
}

class _NextRecurrenceFormField extends StatefulWidget {
  @override
  __NextRecurrenceFormFieldState createState() =>
      __NextRecurrenceFormFieldState();
}

class __NextRecurrenceFormFieldState extends State<_NextRecurrenceFormField> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        DateTime date = model.tempRecurring.nextRecurrence;
        controller.text = DateFormat.yMMMd().format(date);
        return TextFormField(
            decoration: kFormInputDecoration.copyWith(labelText: "Start Date"),
            readOnly: true,
            controller: controller,
            onTap: () async {
              DateTime picked = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(date.year - 5),
                lastDate: DateTime(date.year + 5),
              );
              if (picked != null) {
                model.changeNextRecurrence(picked);
              }
            });
      },
    );
  }
}

class _FrequencyFormField extends StatefulWidget {
  @override
  __FrequencyFormFieldState createState() => __FrequencyFormFieldState();
}

class __FrequencyFormFieldState extends State<_FrequencyFormField> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void changeFrequency(String txt) {
    controller.text = txt;
  }

  showPickerArray(BuildContext context) {
    final model = Provider.of<RecurringViewModel>(context, listen: false);
    new Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: new JsonDecoder().convert(frequencyPickerData),
            isArray: true),
        hideHeader: true,
        title: new Text("Select Frequency"),
        onConfirm: (Picker picker, List value) {
          model.changeInterval(value[0] + 1);
          model.changeFrequencyId(value[1]);
        }).showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        Recurring tempRecurring = model.tempRecurring;
        controller.text = tempRecurring.frequency;
        return TextFormField(
          controller: controller,
          decoration: kFormInputDecoration.copyWith(labelText: "Frequency"),
          readOnly: true,
          onTap: () {
            showPickerArray(context);
          },
        );
      },
    );
  }
}

class _TimeFrameFormField extends StatelessWidget {
  final GlobalKey _menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        int timeFrameId = model.tempRecurring.timeFrameId;
        return PopupMenuButton(
          key: _menuKey,
          initialValue: timeFrameId,
          onSelected: (input) {
            model.changeTimeFrameId(input);
          },
          itemBuilder: (context) {
            return timeFrames
                .map(
                  (e) => PopupMenuItem(
                    value: timeFrames.indexOf(e),
                    child: ListTile(
                      title: Text(e),
                    ),
                  ),
                )
                .toList();
          },
          child: TextFormField(
            initialValue: timeFrames[timeFrameId],
            decoration: kFormInputDecoration.copyWith(labelText: 'Time Frame'),
            readOnly: true,
            onTap: () {
              dynamic state = _menuKey.currentState;
              state.showButtonMenu();
            },
          ),
        );
      },
    );
  }
}

class _TimeFrameHelperFormField extends StatelessWidget {
  final GlobalKey _menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        int timeFrameId = model.tempRecurring.timeFrameId;
        if (timeFrameId == FOREVER) {
          return SizedBox.shrink();
        } else if (timeFrameId == UNTILDATE) {
          return _UntilDateFormField();
        } else {
          return _XTimesFormField();
        }
      },
    );
  }
}

class _UntilDateFormField extends StatefulWidget {
  @override
  __UntilDateFormFieldState createState() => __UntilDateFormFieldState();
}

class __UntilDateFormFieldState extends State<_UntilDateFormField> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(builder: (context, model, child) {
      DateTime date = model.tempRecurring.untilDate;
      controller.text = DateFormat.yMMMd().format(date);
      return TextFormField(
          decoration: kFormInputDecoration.copyWith(labelText: 'Until Date'),
          readOnly: true,
          controller: controller,
          validator: (value) =>
              date.isBefore(model.tempRecurring.nextRecurrence)
                  ? "Please select a date that is after the start date"
                  : null,
          onTap: () async {
            DateTime picked = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(date.year - 5),
              lastDate: DateTime(date.year + 5),
            );
            if (picked != null) {
              model.changeUntilDate(picked);
            }
          });
    });
  }
}

class _XTimesFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        return TextFormField(
          decoration: kFormInputDecoration.copyWith(labelText: 'For X Times'),
          initialValue: model.tempRecurring.xTimes.toString(),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            model.changeXTimes(int.parse(value));
          },
        );
      },
    );
  }
}
