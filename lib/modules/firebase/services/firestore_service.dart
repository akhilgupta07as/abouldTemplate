import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreService {
  Future<Map<String, dynamic>?> getDocument(String path);

  Future<void> setDocument(
    String path,
    Map<String, dynamic> data, {
    bool merge = true,
  });

  Stream<Map<String, dynamic>?> watchDocument(String path);

  Future<String> createDocument(
    String collectionPath,
    Map<String, dynamic> data,
  );

  Future<List<Map<String, dynamic>>> queryCollection({
    required String collectionPath,
    required String field,
    required Object isEqualTo,
    int limit = 100,
  });

  Stream<List<Map<String, dynamic>>> watchQuery({
    required String collectionPath,
    required String field,
    required Object isEqualTo,
    int limit = 100,
  });

  Future<void> patchDocument(String path, Map<String, dynamic> data);

  Future<void> replaceDocument(String path, Map<String, dynamic> data);

  Future<void> deleteDocument(String path);
}

class LiveFirestoreService implements FirestoreService {
  LiveFirestoreService(this._firestore);

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _doc(String path) =>
      _firestore.doc(path);

  CollectionReference<Map<String, dynamic>> _collection(String path) =>
      _firestore.collection(path);

  Query<Map<String, dynamic>> _userQuery({
    required String collectionPath,
    required String field,
    required Object isEqualTo,
    int limit = 100,
  }) {
    return _collection(collectionPath)
        .where(field, isEqualTo: isEqualTo)
        .orderBy('createdAt', descending: true)
        .limit(limit);
  }

  @override
  Future<Map<String, dynamic>?> getDocument(String path) async {
    final snap = await _doc(path).get();
    return snap.data();
  }

  @override
  Future<void> setDocument(
    String path,
    Map<String, dynamic> data, {
    bool merge = true,
  }) {
    return _doc(path).set(data, SetOptions(merge: merge));
  }

  @override
  Stream<Map<String, dynamic>?> watchDocument(String path) {
    return _doc(path).snapshots().map((snap) => snap.data());
  }

  @override
  Future<String> createDocument(
    String collectionPath,
    Map<String, dynamic> data,
  ) async {
    final ref = await _collection(collectionPath).add(data);
    return ref.id;
  }

  @override
  Future<List<Map<String, dynamic>>> queryCollection({
    required String collectionPath,
    required String field,
    required Object isEqualTo,
    int limit = 100,
  }) async {
    final snap = await _userQuery(
      collectionPath: collectionPath,
      field: field,
      isEqualTo: isEqualTo,
      limit: limit,
    ).get();
    return snap.docs
        .map((d) => {...d.data(), 'id': d.id})
        .toList(growable: false);
  }

  @override
  Stream<List<Map<String, dynamic>>> watchQuery({
    required String collectionPath,
    required String field,
    required Object isEqualTo,
    int limit = 100,
  }) {
    return _userQuery(
      collectionPath: collectionPath,
      field: field,
      isEqualTo: isEqualTo,
      limit: limit,
    ).snapshots().map(
          (snap) => snap.docs
              .map((d) => {...d.data(), 'id': d.id})
              .toList(growable: false),
        );
  }

  @override
  Future<void> patchDocument(String path, Map<String, dynamic> data) {
    return _doc(path).update(data);
  }

  @override
  Future<void> replaceDocument(String path, Map<String, dynamic> data) {
    return _doc(path).set(data, SetOptions(merge: false));
  }

  @override
  Future<void> deleteDocument(String path) {
    return _doc(path).delete();
  }
}

class NoOpFirestoreService implements FirestoreService {
  @override
  Future<Map<String, dynamic>?> getDocument(String path) async => null;

  @override
  Future<void> setDocument(
    String path,
    Map<String, dynamic> data, {
    bool merge = true,
  }) async {}

  @override
  Stream<Map<String, dynamic>?> watchDocument(String path) {
    return Stream.value(null);
  }

  @override
  Future<String> createDocument(
    String collectionPath,
    Map<String, dynamic> data,
  ) async =>
      'noop-id';

  @override
  Future<List<Map<String, dynamic>>> queryCollection({
    required String collectionPath,
    required String field,
    required Object isEqualTo,
    int limit = 100,
  }) async =>
      [];

  @override
  Stream<List<Map<String, dynamic>>> watchQuery({
    required String collectionPath,
    required String field,
    required Object isEqualTo,
    int limit = 100,
  }) {
    return Stream.value([]);
  }

  @override
  Future<void> patchDocument(String path, Map<String, dynamic> data) async {}

  @override
  Future<void> replaceDocument(String path, Map<String, dynamic> data) async {}

  @override
  Future<void> deleteDocument(String path) async {}
}
