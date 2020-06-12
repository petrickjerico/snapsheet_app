import 'package:flutter/material.dart';

class BulkInputScreen extends StatelessWidget {
  static const String id = 'bulkinput_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(),
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
