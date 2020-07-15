import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/recurring/recurring_viewmodel.dart';
import 'package:snapsheetapp/ui/components/empty_state.dart';
import 'package:snapsheetapp/ui/screens/recurring/add_recurring_screen.dart';
import 'package:snapsheetapp/ui/screens/recurring/recurring_tile.dart';

class RecurringScreen extends StatelessWidget {
  static const String id = "recurring_screen";

  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Recurring Expenses"),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: model.recurrings.isEmpty
                  ? EmptyState(
                      message: "Create your first recurring record.",
                      icon: Icon(
                        Icons.add_circle,
                        color: Colors.grey,
                        size: 120,
                      ),
                      messageColor: Colors.grey,
                      onTap: () {
                        model.newRecurring();
                        return Navigator.pushNamed(
                            context, AddRecurringScreen.id);
                      },
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final recurring = model.recurrings[index];
                        return RecurringTile(
                          recurring: recurring,
                          index: index,
                        );
                      },
                      itemCount: model.recurrings.length,
                    ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.black,
            onPressed: () {
              model.newRecurring();
              return Navigator.pushNamed(context, AddRecurringScreen.id);
            },
          ),
        );
      },
    );
  }
}
