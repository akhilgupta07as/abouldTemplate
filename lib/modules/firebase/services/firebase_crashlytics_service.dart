import 'package:abould_ada/core/utils/app_logger.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

abstract class FirebaseCrashlyticsService {
  Future<void> configure(AppLogger logger);
}

class LiveFirebaseCrashlyticsService implements FirebaseCrashlyticsService {
  LiveFirebaseCrashlyticsService(this._crashlytics);

  final FirebaseCrashlytics _crashlytics;

  @override
  Future<void> configure(AppLogger logger) async {
    await _crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);

    FlutterError.onError = (details) {
      logger.error('FlutterError', details.exception, details.stack);
      _crashlytics.recordFlutterFatalError(details);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      logger.error('Uncaught error', error, stack);
      _crashlytics.recordError(error, stack, fatal: true);
      return true;
    };

    logger.info('Crashlytics configured');
  }
}

class NoOpFirebaseCrashlyticsService implements FirebaseCrashlyticsService {
  @override
  Future<void> configure(AppLogger logger) async {
    logger.info('Crashlytics disabled (Firebase off)');
  }
}
