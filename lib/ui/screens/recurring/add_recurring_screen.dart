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
      appBar: AppBar(
        title: Text("Add recurring expense"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        int categoryId = model.tempRecurring.categoryId;
        return OutlineButton(
            padding: EdgeInsets.all(10.0),
            child: PopupMenuButton(
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
              child: Text(
                categories[categoryId].title,
                style: TextStyle(color: Colors.white),
              ),
            ));
      },
    );
  }
}

class _AccountFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        String accountUid = model.tempRecurring.accountUid;
        Account account = model.getAccountFromUid(accountUid);
        return OutlineButton(
            padding: EdgeInsets.all(10.0),
            child: PopupMenuButton(
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
              child: Text(
                account.title,
                style: TextStyle(color: Colors.white),
              ),
            ));
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
        return OutlineButton(
            padding: EdgeInsets.all(10.0),
            child: Text(
              DateFormat.yMMMd().format(date),
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
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
