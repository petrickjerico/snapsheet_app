import 'package:flutter/material.dart';

class BulkInputScreen extends StatelessWidget {
  static const String id = 'bulkinput_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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
        title: Text('BULK INPUT'),
      ),
      body: Center(
        child: Text(
          'Here, user inputs receipts in bulk from gallery.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
    );
    ;
  }
}
