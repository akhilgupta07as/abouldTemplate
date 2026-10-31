import 'package:abould_ada/modules/authentication/data/supabase_auth_mapper.dart';
import 'package:abould_ada/modules/authentication/domain/auth_exception.dart';
import 'package:abould_ada/modules/authentication/domain/auth_repository.dart';
import 'package:abould_ada/modules/authentication/domain/auth_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._client);

  final SupabaseClient _client;

  GoTrueClient get _auth => _client.auth;

  @override
  Stream<AuthUser?> authStateChanges() {
    return _auth.onAuthStateChange.map(
      (event) => SupabaseAuthMapper.fromUser(event.session?.user),
    );
  }

  @override
  AuthUser? get currentUser => SupabaseAuthMapper.fromUser(_auth.currentUser);

  @override
  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
      final user = SupabaseAuthMapper.fromUser(response.user);
      if (user == null) {
        throw const AuthFailure('Sign in failed. Please try again.');
      }
      return user;
    } on AuthException catch (e) {
      throw SupabaseAuthMapper.mapException(e);
    }
  }

  @override
  Future<AuthUser> registerWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final response = await _auth.signUp(
        email: email.trim(),
        password: password,
        data: displayName != null && displayName.trim().isNotEmpty
            ? {'full_name': displayName.trim()}
            : null,
      );
      var user = SupabaseAuthMapper.fromUser(response.user);
      if (user == null) {
        throw const AuthFailure('Registration failed. Please try again.');
      }
      // When confirm-email is off, Supabase returns a session — treat as verified.
      if (response.session != null && !user.emailVerified) {
        user = AuthUser(
          id: user.id,
          email: user.email,
          displayName: user.displayName,
          emailVerified: true,
        );
      }
      return user;
    } on AuthException catch (e) {
      throw SupabaseAuthMapper.mapException(e);
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final email = _auth.currentUser?.email;
    if (email == null || email.isEmpty) {
      throw const AuthFailure('You are not signed in.');
    }
    try {
      await _auth.resend(type: OtpType.signup, email: email);
    } on AuthException catch (e) {
      throw SupabaseAuthMapper.mapException(e);
    }
  }

  @override
  Future<void> reloadUser() async {
    try {
      await _auth.refreshSession();
    } on AuthException catch (e) {
      throw SupabaseAuthMapper.mapException(e);
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.resetPasswordForEmail(email.trim());
    } on AuthException catch (e) {
      throw SupabaseAuthMapper.mapException(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on AuthException catch (e) {
      throw SupabaseAuthMapper.mapException(e);
    }
  }
}
