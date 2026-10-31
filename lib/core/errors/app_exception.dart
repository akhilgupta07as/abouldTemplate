import 'package:equatable/equatable.dart';

/// Domain-level exception with a safe user-facing message.
class AppException extends Equatable implements Exception {
  const AppException({
    required this.message,
    this.code,
    this.cause,
  });

  final String message;
  final String? code;
  final Object? cause;

  @override
  List<Object?> get props => [message, code, cause];

  @override
  String toString() => 'AppException($code): $message';
}
