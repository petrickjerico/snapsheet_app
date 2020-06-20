import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

class ProfileSetupScreen extends StatefulWidget {
  static const String id = 'profile_setup';
  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen>
    with AfterLayoutMixin<ProfileSetupScreen> {
  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Hello'),
    );
  }
}
