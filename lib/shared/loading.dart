import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snapsheetapp/shared/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBlack,
      child: Center(
        child: SpinKitChasingDots(
          color: kCyan,
          size: 80,
        ),
      ),
    );
  }
}
