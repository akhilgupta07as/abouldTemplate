import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class FirebaseStorageService {
  Future<String> uploadFile({
    required String storagePath,
    required String localFilePath,
    String? contentType,
  });
}

class LiveFirebaseStorageService implements FirebaseStorageService {
  LiveFirebaseStorageService(this._storage);

  final FirebaseStorage _storage;

  @override
  Future<String> uploadFile({
    required String storagePath,
    required String localFilePath,
    String? contentType,
  }) async {
    final ref = _storage.ref(storagePath);
    final file = File(localFilePath);
    final metadata = contentType != null
        ? SettableMetadata(contentType: contentType)
        : null;
    await ref.putFile(file, metadata);
    return ref.getDownloadURL();
  }
}

class NoOpFirebaseStorageService implements FirebaseStorageService {
  @override
  Future<String> uploadFile({
    required String storagePath,
    required String localFilePath,
    String? contentType,
  }) async {
    return '';
  }
}
