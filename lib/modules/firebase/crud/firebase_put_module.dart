import 'package:abould_ada/modules/firebase/constants/firestore_paths.dart';
import 'package:abould_ada/modules/firebase/models/todo_model.dart';
import 'package:abould_ada/modules/firebase/services/firestore_service.dart';

class FirebasePutModule {
  FirebasePutModule(this._firestore);

  final FirestoreService _firestore;

  Future<void> replaceTodo({
    required TodoModel todo,
    required String todoname,
    required bool iscompleted,
  }) async {
    await _firestore.replaceDocument(
      FirestorePaths.todoDocument(todo.id),
      {
        'userref': todo.userref,
        'todoname': todoname,
        'iscompleted': iscompleted,
        'createdAt': todo.createdAt,
      },
    );
  }
}
