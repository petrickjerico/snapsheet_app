import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/history_tile.dart';
import 'package:snapsheetapp/models/user_data.dart';

class HistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userData, child) {
      return Align(
        alignment: Alignment.topCenter,
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final record = userData.records[index];
            return HistoryTile(record: record, index: index);
          },
          itemCount: userData.recordsCount,
        ),
      );
    });
  }
}
