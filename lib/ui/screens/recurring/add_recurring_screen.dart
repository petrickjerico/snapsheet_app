import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/default_data/recurring.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/recurring/recurring_viewmodel.dart';
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
      backgroundColor: kBlack,
      appBar: AppBar(
        title: Text("Add recurring expense"),
      ),
      body: Theme(
        data: ThemeData.dark(),
        child: SingleChildScrollView(
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
                  Divider(color: Colors.white54),
                  SizedBox(height: 10),
                  _NextRecurrenceFormField(),
                  SizedBox(height: 10),
                  _FrequencyFormField(),
                  SizedBox(height: 10),
                  _TimeFrameFormField(),
                  SizedBox(height: 10),
                  _TimeFrameHelperFormField(),
                ],
              ),
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
          decoration: kTitleEditInfoInputDecoration,
          cursorColor: Colors.white,
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
            keyboardType: TextInputType.number,
            cursorColor: Colors.white,
            decoration:
                kTitleEditInfoInputDecoration.copyWith(labelText: 'Value'),
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
        int categoryId = model.tempRecurring.categoryId;
        return PopupMenuButton(
          key: _menuKey,
          initialValue: categoryId,
          onSelected: (input) {
            model.changeCategory(input);
          },
          itemBuilder: (context) {
            List<String> categoryTitles =
                categories.map((category) => category.title).toList();
            return categoryTitles
                .map(
                  (e) => PopupMenuItem(
                    value: categoryTitles.indexOf(e),
                    child: ListTile(
                      leading: categories[categoryTitles.indexOf(e)].icon,
                      title: Text(e),
                    ),
                  ),
                )
                .toList();
          },
          child: TextFormField(
            initialValue: categories[categoryId].title,
            decoration:
                kTitleEditInfoInputDecoration.copyWith(labelText: 'Category'),
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
          key: _menuKey,
          initialValue: account.index,
          onSelected: (input) {
            model.changeAccount(input);
          },
          itemBuilder: (context) {
            List<String> accountTitles =
                model.accounts.map((acc) => acc.title).toList();
            return accountTitles
                .map(
                  (e) => PopupMenuItem(
                    value: accountTitles.indexOf(e),
                    child: ListTile(
                      title: Text(e),
                    ),
                  ),
                )
                .toList();
          },
          child: TextFormField(
            initialValue: account.title,
            decoration:
                kTitleEditInfoInputDecoration.copyWith(labelText: 'Account'),
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

class _NextRecurrenceFormField extends StatelessWidget {
  DateTime date;
  @override
  Widget build(BuildContext context) {
    print("DATE REBUILD");
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        date = model.tempRecurring.nextRecurrence;
        print(DateFormat.yMMMd().format(date));
        return TextFormField(
            initialValue: DateFormat.yMMMd().format(date),
            decoration:
                kTitleEditInfoInputDecoration.copyWith(labelText: 'Start Date'),
            readOnly: true,
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(date.year - 5),
                lastDate: DateTime(date.year + 5),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.dark(),
                    child: child,
                  );
                },
              ).then((value) {
                model.changeNextRecurrence(value);
              });
            });
      },
    );
  }
}

class _FrequencyFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        Recurring tempRecurring = model.tempRecurring;
        return TextFormField(
          initialValue: tempRecurring.frequency,
          decoration:
              kTitleEditInfoInputDecoration.copyWith(labelText: 'Frequency'),
          readOnly: true,
          onTap: () {
            showDialog(
              context: context,
              child: _FrequencyDialog(),
            );
          },
        );
      },
    );
  }
}

class _FrequencyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecurringViewModel>(context);
    print("REBUILD");
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
  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        return TextFormField(
          textAlign: TextAlign.center,
          initialValue: model.tempRecurring.interval.toString(),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            model.changeInterval(int.parse(value));
          },
        );
      },
    );
  }
}

class _FrequencyDialogFrequencyFormField extends StatelessWidget {
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
            decoration:
                kTitleEditInfoInputDecoration.copyWith(labelText: 'Timeframe'),
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

class _UntilDateFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        DateTime date = model.tempRecurring.untilDate;
        return TextFormField(
            initialValue: DateFormat.yMMMd().format(date),
            decoration:
                kTitleEditInfoInputDecoration.copyWith(labelText: 'Until Date'),
            readOnly: true,
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(date.year - 5),
                lastDate: DateTime(date.year + 5),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.dark(),
                    child: child,
                  );
                },
              ).then((value) {
                model.changeUntilDate(DateTime(
                  value.year,
                  value.month,
                  value.day,
                ));
              });
            });
      },
    );
  }
}

class _XTimesFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        return TextFormField(
          decoration:
              kTitleEditInfoInputDecoration.copyWith(labelText: "For X times"),
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
