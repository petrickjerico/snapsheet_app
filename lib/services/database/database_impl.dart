import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snapsheetapp/business_logic/default_data/accounts.dart';
import 'package:snapsheetapp/business_logic/default_data/records.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/services/database/database.dart';
export 'database.dart';

class DatabaseServiceImpl implements DatabaseService {
  final Firestore _db = Firestore.instance;
  final String uid;
  DocumentReference userDocument;
  CollectionReference recordCollection;
  CollectionReference accountCollection;
  CollectionReference recurringCollection;
  CollectionReference categoryCollection;

  DatabaseServiceImpl({this.uid}) {
    userDocument = Firestore.instance.collection('users').document(uid);
    recordCollection = userDocument.collection('records');
    accountCollection = userDocument.collection('accounts');
    recurringCollection = userDocument.collection('recurring');
  }

  Future<void> initialize() async {
    Map<int, String> map = {};
    for (int i = 0; i < accounts.length; i++) {
      String accountUid = await addAccount(accounts[i]);
      map[i] = accountUid;
    }
    for (Record record in records) {
      record.accountUid = map[record.accountId];
      await addRecord(record);
    }
  }

  /// CREATE
  @override
  Future<String> addRecord(Record record) async {
    final recordDocument = recordCollection.document();
    final uid = recordDocument.documentID;
    Map<String, dynamic> json = record.toJson();
    json['uid'] = uid;
    recordDocument.setData(json);
    return uid;
  }

  @override
  Future<String> addAccount(Account account) async {
    final accountDocument = accountCollection.document();
    final uid = accountDocument.documentID;
    Map<String, dynamic> json = account.toJson();
    json['uid'] = uid;
    accountDocument.setData(json);
    return uid;
  }

  @override
  Future<String> addRecurring(Recurring recurring) async {
    final recurringDocument = recurringCollection.document();
    final uid = recurringDocument.documentID;
    Map<String, dynamic> json = recurring.toJson();
    json['uid'] = uid;
    recurringDocument.setData(json);
    return uid;
  }

  /// READ
  @override
  Future<List<Record>> getRecords() async {
    List<DocumentSnapshot> snapshots =
        await recordCollection.getDocuments().then((value) => value.documents);
    return snapshots.map((doc) => Record.fromFirestore(doc)).toList();
  }

  @override
  Future<List<Account>> getAccounts() async {
    List<DocumentSnapshot> snapshots =
        await accountCollection.getDocuments().then((value) => value.documents);
    return snapshots.map((doc) => Account.fromFirestore(doc)).toList();
  }

  @override
  Future<List<Recurring>> getRecurrings() async {
    List<DocumentSnapshot> snapshots = await recurringCollection
        .getDocuments()
        .then((value) => value.documents);
    return snapshots.map((doc) => Recurring.fromFirestore(doc)).toList();
  }

  /// UPDATE
  @override
  Future<void> updateRecord(Record record) async {
    recordCollection.document(record.uid).setData(record.toJson());
  }

  @override
  Future<void> updateAccount(Account account) async {
    accountCollection.document(account.uid).setData(account.toJson());
  }

  @override
  Future<void> updateRecurring(Recurring recurring) async {
    recurringCollection.document(recurring.uid).setData(recurring.toJson());
  }

  /// DELETE
  @override
  Future<void> deleteRecord(Record record) async {
    recordCollection.document(record.uid).delete();
  }

  @override
  Future<void> deleteAccount(Account account) async {
    accountCollection.document(account.uid).delete();
  }

  @override
  Future<void> deleteRecurring(Recurring recurring) async {
    recurringCollection.document(recurring.uid).delete();
  }
}
