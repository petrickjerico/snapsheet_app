import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/recurring/recurring_viewmodel.dart';
import 'package:snapsheetapp/ui/screens/recurring/recurring_tile.dart';

class RecurringScreen extends StatelessWidget {
  static const String id = "recurring_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recurring Expenses"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Consumer<RecurringViewModel>(
            builder: (context, model, child) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final recurring = model.recurrings[index];
                  return RecurringTile(
                    recurring: recurring,
                    index: index,
                  );
                },
                itemCount: model.recurrings.length,
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(),
      ),
    );
  }
}