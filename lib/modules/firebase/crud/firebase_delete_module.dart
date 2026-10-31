import 'package:abould_ada/modules/firebase/constants/firestore_paths.dart';
import 'package:abould_ada/modules/firebase/services/firestore_service.dart';

class FirebaseDeleteModule {
  FirebaseDeleteModule(this._firestore);

  final FirestoreService _firestore;

  Future<void> deleteTodo(String todoId) async {
    await _firestore.deleteDocument(FirestorePaths.todoDocument(todoId));
  }
}
