import 'package:abould_ada/core/utils/app_logger.dart';
import 'package:abould_ada/modules/firebase/config/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

abstract final class FirebaseInitializer {
  static Future<FirebaseApp> initialize(AppLogger logger) async {
    final app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    logger.info('Firebase initialized (${app.options.projectId})');
    return app;
  }
}
