import 'package:flutter/cupertino.dart';
import 'package:snapsheetapp/business_logic/view_models/receipt_preview/receipt_preview_basemodel.dart';

class ReceiptPreviewViewModel extends ChangeNotifier
    implements ReceiptPreviewBaseModel {
  int accountId;
  List<Asset> assets;
  List<File> images = [];
  List<Record> records = [];
  int counter = 0;
  Scanner scanner = Scanner();
  UserData userData;

  RecordPreview({this.accountId, this.assets, this.userData});

  Future initialize() async {
    await assetsToImages();
    await imagesToRecords();
  }

  Future assetsToImages() async {
    final directory = await getApplicationDocumentsDirectory();
    String path;
    for (Asset asset in assets) {
      ByteData byteData = await asset.getByteData();
      path = '${directory.path}/what${counter++}';
      print(path);
      final buffer = byteData.buffer;
      File image = await File(path).writeAsBytes(
          buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      print(image.toString());
      images.add(image);
    }
  }

  Future imagesToRecords() async {
    for (File image in images) {
      Map<String, dynamic> map = await scanner.getData(image);
      Record record = Record.fromReceipt(
          title: map['title'],
          value: map['value'],
          dateTime: map['date'],
          categoryId: map['catId'],
          id: accountId,
          image: image,
          toDelete: false);
      records.add(record);
    }
  }

  void addAll() {
    for (Record record in records) {
      if (record.toDelete) continue;
      userData.records.add(record);
    }
  }
}
