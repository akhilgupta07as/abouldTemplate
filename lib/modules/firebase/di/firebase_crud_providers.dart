import 'package:abould_ada/core/di/localization_providers.dart';
import 'package:abould_ada/core/di/providers.dart';
import 'package:abould_ada/modules/authentication/presentation/providers/auth_providers.dart';
import 'package:abould_ada/modules/firebase/crud/firebase_delete_module.dart';
import 'package:abould_ada/modules/firebase/crud/firebase_get_module.dart';
import 'package:abould_ada/modules/firebase/crud/firebase_patch_module.dart';
import 'package:abould_ada/modules/firebase/crud/firebase_post_module.dart';
import 'package:abould_ada/modules/firebase/crud/firebase_put_module.dart';
import 'package:abould_ada/modules/firebase/data/firebase_todos_repository.dart';
import 'package:abould_ada/modules/firebase/di/firebase_providers.dart';
import 'package:abould_ada/modules/firebase/models/todo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseGetModuleProvider = Provider<FirebaseGetModule>(
  (ref) => FirebaseGetModule(ref.watch(firestoreServiceProvider)),
);

final firebasePostModuleProvider = Provider<FirebasePostModule>(
  (ref) => FirebasePostModule(ref.watch(firestoreServiceProvider)),
);

final firebasePutModuleProvider = Provider<FirebasePutModule>(
  (ref) => FirebasePutModule(ref.watch(firestoreServiceProvider)),
);

final firebasePatchModuleProvider = Provider<FirebasePatchModule>(
  (ref) => FirebasePatchModule(ref.watch(firestoreServiceProvider)),
);

final firebaseDeleteModuleProvider = Provider<FirebaseDeleteModule>(
  (ref) => FirebaseDeleteModule(ref.watch(firestoreServiceProvider)),
);

final firebaseTodosRepositoryProvider = Provider<FirebaseTodosRepository>(
  (ref) => FirebaseTodosRepository(
    getModule: ref.watch(firebaseGetModuleProvider),
    postModule: ref.watch(firebasePostModuleProvider),
    patchModule: ref.watch(firebasePatchModuleProvider),
    deleteModule: ref.watch(firebaseDeleteModuleProvider),
    translationService: ref.watch(translationServiceProvider),
  ),
);

@Deprecated('Use firebaseTodosRepositoryProvider')
final firebaseDemoItemsRepositoryProvider = firebaseTodosRepositoryProvider;

final firebaseCrudEnabledProvider = Provider<bool>((ref) {
  final config = ref.watch(appConfigProvider);
  if (!config.useFirebase) return false;
  if (ref.watch(authSessionBackendProvider) != AuthBackend.firebase) {
    return false;
  }
  final uid = ref.watch(currentAuthUserProvider)?.id;
  return uid != null && uid.isNotEmpty;
});

final firebaseTodosStreamProvider =
    StreamProvider.autoDispose<List<TodoModel>>((ref) {
  if (!ref.watch(firebaseCrudEnabledProvider)) {
    return Stream.value(const []);
  }
  final uid = ref.watch(currentAuthUserProvider)!.id;
  return ref.watch(firebaseTodosRepositoryProvider).watchForUser(uid);
});

@Deprecated('Use firebaseTodosStreamProvider')
final firebaseDemoItemsStreamProvider = firebaseTodosStreamProvider;
