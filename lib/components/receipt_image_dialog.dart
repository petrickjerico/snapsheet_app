import 'dart:io';

import 'package:flutter/material.dart';

class ReceiptImageDialog extends StatelessWidget {
  final File imageFile;

  //testing

  ReceiptImageDialog(this.imageFile);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: FileImage(imageFile), fit: BoxFit.cover)),
      ),
    );
  }
}
