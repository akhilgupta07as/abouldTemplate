import 'package:abould_ada/modules/firebase/firebase_bootstrap.dart';
import 'package:abould_ada/modules/firebase/services/firebase_analytics_service.dart';
import 'package:abould_ada/modules/firebase/services/firebase_messaging_service.dart';
import 'package:abould_ada/modules/firebase/services/firebase_storage_service.dart';
import 'package:abould_ada/modules/firebase/services/firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseServicesProvider = Provider<FirebaseServices>(
  (ref) => throw UnimplementedError('Register FirebaseServices in AppBindings.'),
);

final firestoreServiceProvider = Provider<FirestoreService>(
  (ref) => ref.watch(firebaseServicesProvider).firestore,
);

final firebaseStorageServiceProvider = Provider<FirebaseStorageService>(
  (ref) => ref.watch(firebaseServicesProvider).storage,
);

final firebaseMessagingServiceProvider = Provider<FirebaseMessagingService>(
  (ref) => ref.watch(firebaseServicesProvider).messaging,
);

final firebaseAnalyticsServiceProvider = Provider<FirebaseAnalyticsService>(
  (ref) => ref.watch(firebaseServicesProvider).analytics,
);

final fcmTokenProvider = FutureProvider<String?>((ref) async {
  return ref.watch(firebaseMessagingServiceProvider).getToken();
});
