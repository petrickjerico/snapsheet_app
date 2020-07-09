import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snapsheetapp/ui/config/config.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBlack,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 80,
        ),
      ),
    );
  }
}
