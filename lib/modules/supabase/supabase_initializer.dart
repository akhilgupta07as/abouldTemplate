import 'package:abould_ada/core/config/app_config.dart';
import 'package:abould_ada/core/utils/app_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract final class SupabaseInitializer {
  static Future<bool> initialize({
    required AppConfig config,
    required AppLogger logger,
  }) async {
    if (!config.isSupabaseConfigured) {
      logger.info(
        'Supabase skipped (set SUPABASE_PUBLISHABLE_KEY or SUPABASE_ANON_KEY)',
      );
      return false;
    }

    try {
      await Supabase.initialize(
        url: config.supabaseUrl,
        publishableKey: config.supabaseClientKey,
        authOptions: const FlutterAuthClientOptions(
          authFlowType: AuthFlowType.pkce,
        ),
      );
      logger.info('Supabase ready (${config.supabaseUrl})');
      return true;
    } catch (e, st) {
      logger.error('Supabase init failed', e, st);
      return false;
    }
  }
}
