import 'package:abould_ada/core/localization/bilingual_text.dart';
import 'package:abould_ada/modules/firebase/constants/firestore_paths.dart';
import 'package:abould_ada/modules/firebase/models/todo_model.dart';
import 'package:abould_ada/modules/firebase/services/firestore_service.dart';

class FirebasePostModule {
  FirebasePostModule(this._firestore);

  final FirestoreService _firestore;

  Future<TodoModel> createTodo({
    required String userref,
    required BilingualText text,
  }) async {
    final draft = TodoModel(
      id: '',
      userref: userref,
      todoname: text.english.isNotEmpty ? text.english : text.hindi,
      english: text.english,
      hindi: text.hindi,
      iscompleted: false,
      createdAt: DateTime.now(),
    );
    final id = await _firestore.createDocument(
      FirestorePaths.todosCollection,
      draft.toCreateMap(),
    );
    return TodoModel(
      id: id,
      userref: userref,
      todoname: draft.todoname,
      english: text.english,
      hindi: text.hindi,
      iscompleted: false,
      createdAt: DateTime.now(),
    );
  }
}
