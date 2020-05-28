import 'package:flutter/material.dart';

class HistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.grey,
      child: Center(
        child: Text(
          'History page goes here.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
