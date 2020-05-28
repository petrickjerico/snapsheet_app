import 'package:flutter/material.dart';
import 'package:snapsheetapp/screens/addexpenses_screen.dart';

class EditInfoScreen extends StatelessWidget {
  static const String id = 'editinfo_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: FlatButton(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            //TODO: more complex navigation
            Navigator.pop(context);
          },
        ),
        title: Text('EDIT INFORMATION'),
      ),
      body: Center(
        child: Text(
          'User edits details of expenses here.\n\n'
          'User is also brought here after Scan Receipt\n'
          'to confirm scanned info.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.check),
        onPressed: () {
          //TODO: more complex navigation
          Navigator.popUntil(
            context,
            ModalRoute.withName(AddExpensesScreen.id),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 30.0,
          child: Container(
            child: null,
          ),
        ),
      ),
    );
  }
}
