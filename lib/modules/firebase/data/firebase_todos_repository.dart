import 'package:abould_ada/core/services/translation_service.dart';

import 'package:abould_ada/modules/firebase/crud/firebase_delete_module.dart';

import 'package:abould_ada/modules/firebase/crud/firebase_get_module.dart';

import 'package:abould_ada/modules/firebase/crud/firebase_patch_module.dart';

import 'package:abould_ada/modules/firebase/crud/firebase_post_module.dart';

import 'package:abould_ada/modules/firebase/models/todo_model.dart';



class FirebaseTodosRepository {

  FirebaseTodosRepository({

    required FirebaseGetModule getModule,

    required FirebasePostModule postModule,

    required FirebasePatchModule patchModule,

    required FirebaseDeleteModule deleteModule,

    required TranslationService translationService,

  })  : _get = getModule,

        _post = postModule,

        _patch = patchModule,

        _delete = deleteModule,

        _translation = translationService;



  final FirebaseGetModule _get;

  final FirebasePostModule _post;

  final FirebasePatchModule _patch;

  final FirebaseDeleteModule _delete;

  final TranslationService _translation;



  Stream<List<TodoModel>> watchForUser(String userref) =>

      _get.watchTodosForUser(userref);



  Future<TodoModel> create({

    required String userref,

    required String text,

    required String sourceLanguageCode,

  }) async {

    final bilingual = await _translation.buildFromSource(

      text: text,

      sourceLanguageCode: sourceLanguageCode,

    );

    return _post.createTodo(userref: userref, text: bilingual);

  }



  Future<void> edit({

    required TodoModel todo,

    required String text,

    required String sourceLanguageCode,

  }) async {

    final bilingual = await _translation.buildFromSource(

      text: text,

      sourceLanguageCode: sourceLanguageCode,

    );

    await _patch.patchTodo(todoId: todo.id, text: bilingual);

  }



  Future<void> setCompleted({

    required TodoModel todo,

    required bool iscompleted,

  }) =>

      _patch.patchTodo(todoId: todo.id, iscompleted: iscompleted);



  Future<void> toggleCompleted(TodoModel todo) =>

      setCompleted(todo: todo, iscompleted: !todo.iscompleted);



  Future<void> remove(String todoId) => _delete.deleteTodo(todoId);

}


