import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/homepage_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/ui/components/history_tile.dart';
import 'package:snapsheetapp/ui/config/colors.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kHomepageBackgroundTransparency,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Consumer<HomepageViewModel>(
            builder: (context, model, child) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final record = model.records[index];
                  return HistoryTile(
                    record: record,
                    index: index,
                    color: Colors.white54,
                  );
                },
                itemCount: model.records.length,
              );
            },
          ),
        ),
      ),
    );
  }
}