import 'package:flutter/cupertino.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/services/auth/auth_impl.dart';
import 'package:snapsheetapp/services/database/database_impl.dart';
import 'package:snapsheetapp/ui/screens/wrapper.dart';
import 'package:sorted_list/sorted_list.dart';

class HomepageScreenViewModel extends ChangeNotifier {
  final User user;
  final AuthService _auth = AuthServiceImpl();
  DatabaseService _db;
  List<Record> _records =
      SortedList<Record>((r1, r2) => r2.dateTime.compareTo(r1.dateTime));
  List<Account> _accounts = SortedList<Account>((a1, a2) => a1.or)

  HomepageScreenViewModel(this.user) {
    _db = DatabaseServiceImpl(uid: user.uid);
    loadData();
  }

  void loadData() async {
    List<Record> unordered = await _db.getRecords();
    _records.addAll(unordered);
    notifyListeners();
  }

  // CREATE
  Future addRecord(Record record) async {
    _records.add(record);
    notifyListeners();
    Future<String> uid = _db.addRecord(record);
    record.uid = await uid;
  }

  Future addAccount(Account account) async {
    _accounts.add(account);
    notifyListeners();
    Future<String> uid = _db.addAccount(account);
  }

  // READ
  List<Record> get records => _records;

  // UPDATE
  Future updateRecord(int index, Record record) async {
    _db.updateRecord(record);
    _records.removeAt(index);
    _records.add(record);
    notifyListeners();
  }

  // DELETE
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
