import 'package:equatable/equatable.dart';

/// Represents a failed operation result (used by repositories / use cases).
class Failure extends Equatable {
  const Failure({
    required this.message,
    this.code,
  });

  final String message;
  final String? code;

  @override
  List<Object?> get props => [message, code];
}
