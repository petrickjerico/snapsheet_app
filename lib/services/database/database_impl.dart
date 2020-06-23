import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/services/database/database.dart';
export 'database.dart';

class DatabaseServiceImpl implements DatabaseService {
  final Firestore _db = Firestore.instance;
  final String uid;
  DocumentReference userDocument;
  CollectionReference recordCollection;
  CollectionReference accountCollection;
  CollectionReference categoryCollection;

  DatabaseServiceImpl({this.uid}) {
    userDocument = Firestore.instance.collection('users').document(uid);
    recordCollection = userDocument.collection('records');
    accountCollection = userDocument.collection('accounts');
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

  /// UPDATE
  @override
  Future<void> updateRecord(Record record) async {
    recordCollection.document(record.uid).setData(record.toJson());
  }

  @override
  Future<void> updateAccount(Account account) async {
    recordCollection.document(account.uid).setData(account.toJson());
  }

  /// DELETE
  @override
  Future<void> deleteRecord(Record record) async {
    recordCollection.document(record.uid).delete();
  }

  @override
  Future<void> deleteAccount(Account account) async {
    recordCollection.document(account.uid).delete();
  }
}
