import 'package:abould_ada/core/di/providers.dart';
import 'package:abould_ada/modules/authentication/presentation/providers/auth_providers.dart';
import 'package:abould_ada/modules/firebase/constants/firestore_paths.dart';
import 'package:abould_ada/modules/firebase/di/firebase_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final workspaceConfigProvider = StreamProvider<Map<String, dynamic>?>((ref) {
  final config = ref.watch(appConfigProvider);
  if (!config.useFirebase) {
    return Stream.value({
      'welcomeMessage': 'Firebase disabled — using local demo config.',
    });
  }

  final session = ref.watch(authSessionBackendProvider);
  if (session != AuthBackend.firebase) {
    return Stream.value({
      'welcomeMessage':
          'Signed in with API (DummyJSON). Use Firebase on login for Firestore.',
    });
  }

  final authState = ref.watch(authStateProvider);
  return authState.when(
    loading: () => Stream.value({
      'welcomeMessage': 'Connecting Firebase Auth…',
    }),
    error: (_, stackTrace) => Stream.value({
      'welcomeMessage': 'Auth error — try signing in again.',
    }),
    data: (user) {
      if (user == null || user.id.isEmpty) {
        return Stream.value({
          'welcomeMessage':
              'Sign in with Firebase to load your workspace from Firestore.',
        });
      }

      final path = FirestorePaths.workspaceConfig(user.id);
      return ref.watch(firestoreServiceProvider).watchDocument(path).map(
            (data) =>
                data ??
                {
                  'welcomeMessage':
                      'Welcome to Abould ADA — your workspace is ready.',
                },
          );
    },
  );
});

final ensureWorkspaceConfigProvider = FutureProvider<void>((ref) async {
  final config = ref.read(appConfigProvider);
  if (!config.useFirebase) return;
  if (ref.read(authSessionBackendProvider) != AuthBackend.firebase) return;

  final user = ref.read(currentAuthUserProvider);
  if (user == null || user.id.isEmpty) return;

  final firestore = ref.read(firestoreServiceProvider);
  final path = FirestorePaths.workspaceConfig(user.id);

  try {
    final existing = await firestore.getDocument(path);
    if (existing != null) return;

    await firestore.setDocument(
      path,
      {
        'welcomeMessage': 'Welcome to Abould ADA — Firestore is connected.',
        'updatedAt': DateTime.now().toIso8601String(),
      },
      merge: false,
    );
  } catch (_) {
    // Rules or offline — UI uses stream fallback message.
  }
});
