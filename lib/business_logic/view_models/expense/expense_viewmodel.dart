import 'package:flutter/cupertino.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_basemodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';

class ExpenseViewModel extends ChangeNotifier implements ExpenseBaseModel {
  Record tempRecord;
  final UserData userData;

  ExpenseViewModel(this.userData);
}
