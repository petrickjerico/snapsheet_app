import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/models/scanner.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:snapsheetapp/screens/addexpenses_screen.dart';

class ScannerButton extends StatelessWidget {
  final bool isCamera;

  ScannerButton({@required this.isCamera});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userData, child) {
        return IconButton(
          icon: Icon(
            isCamera ? Icons.camera_alt : Icons.photo_library,
            color: Colors.white,
          ),
          onPressed: () async {
            // Setup
            Scanner scanner = Scanner(isCamera: isCamera, userData: userData);
            await scanner.process();
            Navigator.pop(context);
            Navigator.pushNamed((context), AddExpensesScreen.id);
          },
        );
      },
    );
  }
}
