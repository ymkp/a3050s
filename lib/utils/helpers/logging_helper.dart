import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@singleton
class LoggingHelper {
  final Logger logIt = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  final bool isRelease = dotenv.env['ENV'] == 'prod';

  /// Log a message at level [Level.verbose].
  void verbose(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (isRelease && !showInProd) {
      return;
    }

    logIt.v(message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  void debug(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (isRelease && !showInProd) {
      return;
    }

    logIt.d(message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  void info(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (isRelease && !showInProd) {
      return;
    }

    logIt.i(message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  void warn(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (isRelease && !showInProd) {
      return;
    }

    logIt.w(message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  void error(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (isRelease && !showInProd) {
      return;
    }

    logIt.e(message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  void wtf(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (isRelease && !showInProd) {
      return;
    }

    logIt.wtf(message, error, stackTrace);
  }
}
