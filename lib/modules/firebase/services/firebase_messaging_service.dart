import 'package:abould_ada/core/utils/app_logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Extend for background notification handling.
}

abstract class FirebaseMessagingService {
  Future<void> initialize(AppLogger logger);

  Future<String?> getToken();

  Stream<String> get onTokenRefresh;

  /// Stream of messages when user taps a notification and the app is in background.
  Stream<RemoteMessage> get onMessageOpenedApp;

  /// Message that caused the application to open from a terminated state.
  Future<RemoteMessage?> getInitialMessage();
}

class LiveFirebaseMessagingService implements FirebaseMessagingService {
  LiveFirebaseMessagingService(this._messaging);

  final FirebaseMessaging _messaging;

  @override
  Future<void> initialize(AppLogger logger) async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    final token = await _messaging.getToken();
    logger.info('FCM token ready (${token != null ? 'received' : 'null'})');

    FirebaseMessaging.onMessage.listen((message) {
      logger.info('FCM foreground: ${message.notification?.title}');
    });
  }

  @override
  Future<String?> getToken() => _messaging.getToken();

  @override
  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;

  @override
  Stream<RemoteMessage> get onMessageOpenedApp =>
      FirebaseMessaging.onMessageOpenedApp;

  @override
  Future<RemoteMessage?> getInitialMessage() => _messaging.getInitialMessage();
}

class NoOpFirebaseMessagingService implements FirebaseMessagingService {
  @override
  Future<void> initialize(AppLogger logger) async {}

  @override
  Future<String?> getToken() async => null;

  @override
  Stream<String> get onTokenRefresh => const Stream.empty();

  @override
  Stream<RemoteMessage> get onMessageOpenedApp => const Stream.empty();

  @override
  Future<RemoteMessage?> getInitialMessage() async => null;
}
