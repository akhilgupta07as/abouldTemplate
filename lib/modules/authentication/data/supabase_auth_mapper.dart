import 'package:abould_ada/modules/authentication/domain/auth_exception.dart';
import 'package:abould_ada/modules/authentication/domain/auth_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

abstract final class SupabaseAuthMapper {
  static AuthUser? fromUser(User? user) {
    if (user == null) return null;
    final meta = user.userMetadata ?? {};
    final displayName = meta['full_name']?.toString() ??
        meta['display_name']?.toString() ??
        meta['name']?.toString();
    return AuthUser(
      id: user.id,
      email: user.email ?? '',
      displayName: displayName,
      emailVerified: user.emailConfirmedAt != null,
    );
  }

  static AuthFailure mapException(AuthException e) {
    final message = switch (e.message.toLowerCase()) {
      final m when m.contains('invalid login credentials') =>
        'Invalid email or password.',
      final m when m.contains('email not confirmed') =>
        'Confirm your email from the link Supabase sent, then sign in again.',
      final m when m.contains('user already registered') =>
        'An account already exists with this email.',
      final m when m.contains('password') && m.contains('weak') =>
        'Password is too weak. Use at least 8 characters.',
      _ => e.message,
    };
    return AuthFailure(message, code: e.statusCode);
  }
}
