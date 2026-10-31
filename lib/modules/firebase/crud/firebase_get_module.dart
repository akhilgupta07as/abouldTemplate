import 'package:abould_ada/modules/firebase/constants/firestore_paths.dart';
import 'package:abould_ada/modules/firebase/models/todo_model.dart';
import 'package:abould_ada/modules/firebase/services/firestore_service.dart';

class FirebaseGetModule {
  FirebaseGetModule(this._firestore);

  final FirestoreService _firestore;

  Future<List<TodoModel>> listTodosForUser(String userref) async {
    final rows = await _firestore.queryCollection(
      collectionPath: FirestorePaths.todosCollection,
      field: 'userref',
      isEqualTo: userref,
    );
    return rows.map(TodoModel.fromMap).toList(growable: false);
  }

  Stream<List<TodoModel>> watchTodosForUser(String userref) {
    return _firestore
        .watchQuery(
          collectionPath: FirestorePaths.todosCollection,
          field: 'userref',
          isEqualTo: userref,
        )
        .map((rows) => rows.map(TodoModel.fromMap).toList(growable: false));
  }

  Future<TodoModel?> getTodo(String todoId) async {
    final data = await _firestore.getDocument(
      FirestorePaths.todoDocument(todoId),
    );
    if (data == null) return null;
    return TodoModel.fromMap({...data, 'id': todoId});
  }
}
