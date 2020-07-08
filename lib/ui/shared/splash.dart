import 'package:flutter/material.dart';
import 'package:snapsheetapp/ui/config/config.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Text(
            'SNAPSHEET',
            textAlign: TextAlign.center,
            style: kWelcomeTextStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
