import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  const AuthUser({
    required this.id,
    required this.email,
    this.displayName,
    this.emailVerified = false,
  });

  final String id;
  final String email;
  final String? displayName;
  final bool emailVerified;

  @override
  List<Object?> get props => [id, email, displayName, emailVerified];
}
