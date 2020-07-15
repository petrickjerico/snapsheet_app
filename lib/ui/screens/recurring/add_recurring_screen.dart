import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/default_data/categories.dart';
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
              child: Consumer<RecurringViewModel>(
                builder: (context, model, child) {
                  int timeFrameId = model.tempRecurring.timeFrameId;
                  return Column(
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
                    ],
                  );
                },
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
  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        DateTime date = model.tempRecurring.nextRecurrence;
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
                model.changeNextRecurrence(DateTime(
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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text("Repeat every"),
            Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    initialValue: 1.toString(),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: PopupMenuButton(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
