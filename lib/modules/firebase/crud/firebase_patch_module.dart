import 'package:abould_ada/core/localization/bilingual_text.dart';
import 'package:abould_ada/modules/firebase/constants/firestore_paths.dart';
import 'package:abould_ada/modules/firebase/models/todo_model.dart';
import 'package:abould_ada/modules/firebase/services/firestore_service.dart';

class FirebasePatchModule {
  FirebasePatchModule(this._firestore);

  final FirestoreService _firestore;

  Future<void> patchTodo({
    required String todoId,
    BilingualText? text,
    bool? iscompleted,
  }) async {
    final data = <String, dynamic>{};
    if (text != null) {
      data.addAll(text.toFirestoreMap(legacyTodonameKey: 'todoname'));
    }
    if (iscompleted != null) data['iscompleted'] = iscompleted;
    if (data.isEmpty) return;
    await _firestore.patchDocument(FirestorePaths.todoDocument(todoId), data);
  }

  Future<void> updateTodo(
    TodoModel todo, {
    BilingualText? text,
    bool? iscompleted,
  }) {
    return patchTodo(
      todoId: todo.id,
      text: text,
      iscompleted: iscompleted,
    );
  }
}
