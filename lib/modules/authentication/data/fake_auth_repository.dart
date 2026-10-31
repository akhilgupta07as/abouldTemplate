import 'dart:async';

import 'package:abould_ada/modules/authentication/domain/auth_exception.dart';
import 'package:abould_ada/modules/authentication/domain/auth_repository.dart';
import 'package:abould_ada/modules/authentication/domain/auth_user.dart';

/// Used when `USE_FIREBASE=false` (unit/widget tests).
class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository() {
    _controller.add(null);
  }

  final _controller = StreamController<AuthUser?>.broadcast();
  AuthUser? _user;

  @override
  Stream<AuthUser?> authStateChanges() => _controller.stream;

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    if (password.length < 8) {
      throw const AuthFailure('Password must be at least 8 characters.');
    }
    _user = AuthUser(
      id: 'test-user',
      email: email.trim(),
      displayName: 'Test User',
      emailVerified: true,
    );
    _controller.add(_user);
    return _user!;
  }

  @override
  Future<AuthUser> registerWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    _user = AuthUser(
      id: 'test-user',
      email: email.trim(),
      displayName: displayName,
      emailVerified: false,
    );
    _controller.add(_user);
    return _user!;
  }

  @override
  Future<void> sendEmailVerification() async {}

  @override
  Future<void> reloadUser() async {}

  @override
  Future<void> sendPasswordResetEmail(String email) async {}

  @override
  Future<void> signOut() async {
    _user = null;
    _controller.add(null);
  }
}
