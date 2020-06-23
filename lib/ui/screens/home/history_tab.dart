import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userData, child) {
      return Container(
        color: Colors.black.withOpacity(0.8),
        padding:
            EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'History',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final record = userData.records[index];
                      return HistoryTile(record: record, index: index);
                    },
                    itemCount: userData.recordsCount,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
