import 'dart:io';

import 'package:flutter/material.dart';

class ReceiptImageDialog extends StatelessWidget {
  String receiptURL;
  String imagePath;

  ReceiptImageDialog({this.receiptURL, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return receiptURL == null
        ? Dialog(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(File(imagePath)), fit: BoxFit.cover)),
            ),
          )
        : Dialog(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(receiptURL), fit: BoxFit.cover)),
            ),
          );
  }
}
