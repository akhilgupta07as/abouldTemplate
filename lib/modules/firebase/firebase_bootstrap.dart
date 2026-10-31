import 'package:abould_ada/core/config/app_config.dart';
import 'package:abould_ada/core/utils/app_logger.dart';
import 'package:abould_ada/modules/firebase/services/firebase_analytics_service.dart';
import 'package:abould_ada/modules/firebase/services/firebase_crashlytics_service.dart';
import 'package:abould_ada/modules/firebase/services/firebase_messaging_service.dart';
import 'package:abould_ada/modules/firebase/services/firebase_storage_service.dart';
import 'package:abould_ada/modules/firebase/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServices {
  const FirebaseServices({
    required this.analytics,
    required this.crashlytics,
    required this.messaging,
    required this.firestore,
    required this.storage,
  });

  final FirebaseAnalyticsService analytics;
  final FirebaseCrashlyticsService crashlytics;
  final FirebaseMessagingService messaging;
  final FirestoreService firestore;
  final FirebaseStorageService storage;

  factory FirebaseServices.noop() {
    return FirebaseServices(
      analytics: NoOpFirebaseAnalyticsService(),
      crashlytics: NoOpFirebaseCrashlyticsService(),
      messaging: NoOpFirebaseMessagingService(),
      firestore: NoOpFirestoreService(),
      storage: NoOpFirebaseStorageService(),
    );
  }

  factory FirebaseServices.live() {
    return FirebaseServices(
      analytics: LiveFirebaseAnalyticsService(FirebaseAnalytics.instance),
      crashlytics: LiveFirebaseCrashlyticsService(FirebaseCrashlytics.instance),
      messaging: LiveFirebaseMessagingService(FirebaseMessaging.instance),
      firestore: LiveFirestoreService(FirebaseFirestore.instance),
      storage: LiveFirebaseStorageService(FirebaseStorage.instance),
    );
  }
}

abstract final class FirebaseBootstrap {
  static Future<FirebaseServices> configure({
    required AppConfig config,
    required AppLogger logger,
  }) async {
    if (!config.useFirebase) {
      return FirebaseServices.noop();
    }

    final services = FirebaseServices.live();
    await services.crashlytics.configure(logger);
    await services.messaging.initialize(logger);
    logger.info('Firebase services ready (Analytics, FCM, Firestore, Storage)');
    return services;
  }
}
