import 'package:flutter/material.dart';
import 'package:snapsheetapp/ui/config/typography.dart';

class SnapSheetBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: Image.asset('assets/images/snapsheet_logo.png'),
          height: 60.0,
        ),
        Text(
          'SNAPSHEET',
          textAlign: TextAlign.center,
          style: kWelcomeTextStyle,
        ),
      ],
    );
  }
}
