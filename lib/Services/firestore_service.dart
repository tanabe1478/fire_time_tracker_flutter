import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import 'database.dart';

class FirestoreService extends DatabaseService {
  FirestoreService._();
  static final instance = FirestoreService._();
  Future<void> setData({String path, Map<String, dynamic> data}) async {
    final reference = Firestore.instance.document(path);
    print('$path: $data');
    await reference.setData(data);
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentId),
  }) {
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.documents
        .map((snapshot) => builder(snapshot.data, snapshot.documentID))
        .toList());
  }
}
