import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Generated from Firebase project **adaproject-d13b2** (Android).
/// Re-run `flutterfire configure` when adding iOS/web apps.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('Web Firebase options are not configured yet.');
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'Add ios/GoogleService-Info.plist and run flutterfire configure.',
        );
      default:
        throw UnsupportedError(
          'Firebase is not configured for $defaultTargetPlatform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBtxkdsf4KkgmM-f1LaM6GONbsNYoevbFg',
    appId: '1:806267939124:android:f99684a7c8bf4b3f6f5d61',
    messagingSenderId: '806267939124',
    projectId: 'adaproject-d13b2',
    storageBucket: 'adaproject-d13b2.firebasestorage.app',
  );
}
