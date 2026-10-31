import 'package:abould_ada/modules/authentication/domain/auth_exception.dart';
import 'package:abould_ada/modules/authentication/domain/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract final class FirebaseAuthMapper {
  static AuthUser? fromFirebaseUser(User? user) {
    if (user == null) return null;
    return AuthUser(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      emailVerified: user.emailVerified,
    );
  }

  static AuthFailure mapException(FirebaseAuthException e) {
    final message = switch (e.code) {
      'invalid-email' => 'That email address is not valid.',
      'user-disabled' => 'This account has been disabled.',
      'user-not-found' => 'No account found for that email.',
      'wrong-password' => 'Incorrect password. Try again.',
      'invalid-credential' => 'Invalid email or password.',
      'email-already-in-use' => 'An account already exists with this email.',
      'weak-password' => 'Password is too weak. Use at least 8 characters.',
      'too-many-requests' => 'Too many attempts. Please wait and try again.',
      'network-request-failed' => 'Network error. Check your connection.',
      _ => e.message ?? 'Authentication failed. Please try again.',
    };
    return AuthFailure(message, code: e.code);
  }
}
