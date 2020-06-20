import 'package:flutter/material.dart';

class SnapSheetLogo extends StatelessWidget {
  final double size;

  SnapSheetLogo({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Image.asset('assets/images/snapsheet_logo.png'),
    );
  }
}
