import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/default_data/recurring.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/recurring/recurring_viewmodel.dart';
import 'package:snapsheetapp/ui/components/button/rounded_button.dart';
import 'package:snapsheetapp/ui/components/dialog/delete_dialog.dart';
import 'package:snapsheetapp/ui/config/config.dart';

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
                      print("FORM PASS");
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

class _CategoryFormField extends StatelessWidget {
  final GlobalKey _menuKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        String categoryUid = model.tempRecurring.categoryUid;
        Category category = model.userData.getThisCategory(categoryUid);
        return PopupMenuButton(
          captureInheritedThemes: false,
          key: _menuKey,
          initialValue: category.index,
          onSelected: (input) {
            model.changeCategory(input);
          },
          itemBuilder: (context) {
            return model.categories
                .map(
                  (category) => PopupMenuItem(
                    value: model.categories.indexOf(category),
                    child: ListTile(
                      leading: category.icon,
                      title: Text(category.title),
                    ),
                  ),
                )
                .toList();
          },
          child: TextFormField(
            initialValue: category.title,
            decoration: kFormInputDecoration.copyWith(labelText: 'Category'),
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

class _AccountFormField extends StatelessWidget {
  final GlobalKey _menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        String accountUid = model.tempRecurring.accountUid;
        Account account = model.getAccountFromUid(accountUid);
        return PopupMenuButton(
          captureInheritedThemes: false,
          key: _menuKey,
          initialValue: account.index,
          onSelected: (input) {
            model.changeAccount(input);
          },
          itemBuilder: (context) {
            return model.accounts
                .map(
                  (account) => PopupMenuItem(
                    value: model.accounts.indexOf(account),
                    child: ListTile(
                      title: Text(account.title),
                    ),
                  ),
                )
                .toList();
          },
          child: TextFormField(
            initialValue: account.title,
            decoration: kFormInputDecoration.copyWith(labelText: 'Account'),
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
    print("DATE REBUILD");
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
            showDialog(
              context: context,
              child: _FrequencyDialog(callBack: changeFrequency),
            );
          },
        );
      },
    );
  }
}

class _FrequencyDialog extends StatelessWidget {
  Function callBack;

  _FrequencyDialog({this.callBack});
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecurringViewModel>(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 120,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Repeat every",
              style: kFrequencyDialogTextStyle,
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: _FrequencyDialogIntervalFormField(),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Flexible(
                  flex: 3,
                  child: _FrequencyDialogFrequencyFormField(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FrequencyDialogIntervalFormField extends StatelessWidget {
  Function callBack;

  _FrequencyDialogIntervalFormField({this.callBack});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        return TextFormField(
          textAlign: TextAlign.center,
          initialValue: model.tempRecurring.interval.toString(),
          validator: (value) => double.parse(value) <= 0
              ? "Please input a positive number"
              : null,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            model.changeInterval(int.parse(value));
            callBack(model.tempRecurring.frequency);
          },
        );
      },
    );
  }
}

class _FrequencyDialogFrequencyFormField extends StatelessWidget {
  Function callBack;

  _FrequencyDialogFrequencyFormField({this.callBack});

  final GlobalKey _menuKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        int frequencyId = model.tempRecurring.frequencyId;
        return PopupMenuButton(
          key: _menuKey,
          initialValue: frequencyId,
          onSelected: (input) {
            model.changeFrequencyId(input);
            callBack(model.tempRecurring.frequency);
          },
          itemBuilder: (context) {
            List<String> frequencyTitles = singularAndPlural;
            return frequencyTitles
                .map(
                  (e) => PopupMenuItem(
                    value: frequencyTitles.indexOf(e),
                    child: ListTile(
                      title: Text(e),
                    ),
                  ),
                )
                .toList();
          },
          child: TextFormField(
            textAlign: TextAlign.center,
            initialValue: singularAndPlural[frequencyId],
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
              print(model.tempRecurring.toString());
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
