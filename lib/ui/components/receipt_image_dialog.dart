import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ReceiptImageDialog extends StatelessWidget {
  String receiptURL;
  String imagePath;

  ReceiptImageDialog({this.receiptURL, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return receiptURL == null
        ? Dialog(
            child: Container(
              child: PhotoView(
                imageProvider: FileImage(File(imagePath)),
                enableRotation: true,
              ),
            ),
          )
        : Dialog(
            child: Container(
              child: PhotoView(
                imageProvider: NetworkImage(receiptURL),
                enableRotation: true,
              ),
            ),
          );
  }
}
