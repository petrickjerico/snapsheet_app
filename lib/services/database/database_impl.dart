import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/services/database/database.dart';

class DatabaseServiceImpl implements DatabaseService {
  final Firestore _db = Firestore.instance;
  final String uid;
  DocumentReference userDocument;
  CollectionReference recordCollection;

  DatabaseServiceImpl({this.uid}) {
    userDocument = Firestore.instance.collection('users').document(uid);
    recordCollection = userDocument.collection('records');
  }

  @override
  Future<List<Record>> getAllRecords() async {
    List<DocumentSnapshot> snapshots =
        await recordCollection.getDocuments().then((value) => value.documents);
    return snapshots.map((doc) => Record.fromFirestore(doc)).toList();
  }

  @override
  Future<String> addRecord(Record record) async {
    final recordDocument = recordCollection.document();
    final uid = recordDocument.documentID;
    Map<String, dynamic> json = record.toJson();
    json['uid'] = uid;
    await recordDocument.setData(json);
    return uid;
  }

  @override
  Future<void> deleteRecord(Record record) async {
    recordCollection.document(record.uid).delete();
  }

  @override
  Future<void> updateRecord(Record record) async {
    recordCollection.document(record.uid).setData(record.toJson());
  }
}
