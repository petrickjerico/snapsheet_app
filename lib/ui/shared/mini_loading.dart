import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snapsheetapp/ui/config/config.dart';

class MiniLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kScaffoldBackgroundColour,
      child: Center(
        child: SpinKitChasingDots(
          color: kNavyBluePrimary,
          size: 80,
        ),
      ),
    );
  }
}
