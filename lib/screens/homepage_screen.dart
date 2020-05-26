import 'package:flutter/material.dart';

class HomepageScreen extends StatelessWidget {
  static final String id = 'homepage_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'This page intentionally left blank',
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
