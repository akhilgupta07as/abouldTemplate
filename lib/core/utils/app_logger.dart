import 'package:abould_ada/core/config/app_config.dart';
import 'package:logger/logger.dart';

/// Central logging. Disabled in production builds when logging is off in config.
class AppLogger {
  AppLogger(this._config)
      : _logger = Logger(
          printer: PrettyPrinter(methodCount: 0),
          level: _config.enableRequestLogging ? Level.debug : Level.off,
        );

  final AppConfig _config;
  final Logger _logger;

  void debug(String message, [Object? error, StackTrace? stackTrace]) {
    if (!_config.enableRequestLogging) return;
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  void info(String message) {
    if (!_config.enableRequestLogging) return;
    _logger.i(message);
  }

  void warning(String message, [Object? error]) {
    _logger.w(message, error: error);
  }

  void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
