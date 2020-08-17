import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data/user_data_impl.dart';

abstract class HomepageBaseModel {
  void syncBarToPage(int index);
  void init(UserData userData);
  void initEditAccount(int accountIndex);
  String getSelectedAccountUid();
  Account getSelectedAccount();
  List<Account> getAccounts();
  void addAccount(String title, Color color);
  void updateAccount();
  void updateAccountIndex(int oldIndex, int newIndex);
  void deleteAccount();
  void selectAccount(int newIndex);
  bool isOverlaid(int index);
  void toggleTileHasChanged();
  double getSumFromAccount(Account acc);
  void updateDonutTouchedIndex(int i);
  List<PieChartSectionData> showingCategorySections();
  bool selectedAccountIsEmpty();
  bool selectedAccountHasIncome();
  bool selectedAccountHasExpense();
  bool recordMatchesStats(Record rec);
  double getCategoryTotal(int catId);
  double currentExpensesTotal();
  List<double> statsGetBalanceData();
  List<Record> getRecordsFromCurrentAccount();
  List<Record> getTop5Records();
  bool isAccountSelected(int index);
  List<MapEntry<double, double>> getXYMapValues();
  List<FlSpot> getAccountSpots();
  List<LineChartBarData> linesBarData1();
  void toggleBalanceCustom(bool value);
  void toggleExpenseBreakdownCustom(bool value);
  void toggleAmountTrendCustom(bool value);
}
