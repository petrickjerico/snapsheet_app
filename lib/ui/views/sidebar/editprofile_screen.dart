import 'package:flutter/material.dart';
import 'package:snapsheetapp/ui/config/colors.dart';

class EditProfileScreen extends StatelessWidget {
  static const String id = 'editprofile_screen';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'User details will appear here.',
        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white54),
      ),
    );
  }
}
