import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  static const String id = 'editprofile_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(),
        title: Text('EDIT PROFILE'),
      ),
      body: Center(
        child: Text(
          'User details will appear here.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
