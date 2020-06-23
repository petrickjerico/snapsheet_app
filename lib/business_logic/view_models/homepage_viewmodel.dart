import 'package:flutter/cupertino.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/services/auth/auth_impl.dart';
import 'package:sorted_list/sorted_list.dart';

class HistoryScreenViewModel extends ChangeNotifier {
  final User user;
  final AuthServiceImpl _auth = AuthServiceImpl();
  DatabaseService _db;
  List<Record> _records =
      SortedList<Record>((r1, r2) => r2.dateTime.compareTo(r1.dateTime));

  HistoryScreenViewModel(this.user) {
    _db = DatabaseServiceImpl(uid: user.uid);
    loadData();
  }

  void loadData() async {
    List<Record> unordered = await _db.getAllRecords();
    _records.addAll(unordered);
    notifyListeners();
  }

  List<Record> get records => _records;

  Future addRecord(Record record) async {
    _records.add(record);
    notifyListeners();
    Future<String> uid = _db.addRecord(record);
    record.uid = await uid;
  }

  Future updateRecord(int index, Record record) async {
    _db.updateRecord(record);
    _records.removeAt(index);
    _records.add(record);
    notifyListeners();
  }

  Future deleteRecord(Record record) async {
    _db.deleteRecord(record);
    print(record.uid);
    _records.remove(record);
    notifyListeners();
  }

  Future signOut(BuildContext context) async {
    Navigator.pop(context);
    _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      Wrapper.id,
      (route) => false,
    );
  }
}
