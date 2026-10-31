import 'package:firebase_analytics/firebase_analytics.dart';

abstract class FirebaseAnalyticsService {
  Future<void> logLogin({required String method});

  Future<void> logScreenView({required String screenName});

  Future<void> logEvent(String name, {Map<String, Object>? parameters});
}

class LiveFirebaseAnalyticsService implements FirebaseAnalyticsService {
  LiveFirebaseAnalyticsService(this._analytics);

  final FirebaseAnalytics _analytics;

  @override
  Future<void> logLogin({required String method}) {
    return _analytics.logLogin(loginMethod: method);
  }

  @override
  Future<void> logScreenView({required String screenName}) {
    return _analytics.logScreenView(screenName: screenName);
  }

  @override
  Future<void> logEvent(String name, {Map<String, Object>? parameters}) {
    return _analytics.logEvent(name: name, parameters: parameters);
  }
}

class NoOpFirebaseAnalyticsService implements FirebaseAnalyticsService {
  @override
  Future<void> logLogin({required String method}) async {}

  @override
  Future<void> logScreenView({required String screenName}) async {}

  @override
  Future<void> logEvent(String name, {Map<String, Object>? parameters}) async {}
}
