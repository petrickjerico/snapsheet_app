import 'package:flutter/material.dart';
import 'package:snapsheetapp/ui/config/config.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset('assets/images/snapsheet_logo.png'),
                height: 150.0,
              ),
              Text(
                'SNAPSHEET',
                textAlign: TextAlign.center,
                style: kWelcomeTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
