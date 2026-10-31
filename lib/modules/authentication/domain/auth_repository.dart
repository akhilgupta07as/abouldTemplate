import 'package:abould_ada/modules/authentication/domain/auth_user.dart';

abstract class AuthRepository {
  Stream<AuthUser?> authStateChanges();

  AuthUser? get currentUser;

  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
  });

  Future<AuthUser> registerWithEmail({
    required String email,
    required String password,
    String? displayName,
  });

  Future<void> sendEmailVerification();

  Future<void> reloadUser();

  Future<void> sendPasswordResetEmail(String email);

  Future<void> signOut();
}
