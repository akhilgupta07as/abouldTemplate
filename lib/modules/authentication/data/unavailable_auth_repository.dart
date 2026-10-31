import 'package:abould_ada/modules/authentication/domain/auth_exception.dart';
import 'package:abould_ada/modules/authentication/domain/auth_repository.dart';
import 'package:abould_ada/modules/authentication/domain/auth_user.dart';

class UnavailableAuthRepository implements AuthRepository {
  UnavailableAuthRepository(this._reason);

  final String _reason;

  @override
  Stream<AuthUser?> authStateChanges() => Stream.value(null);

  @override
  AuthUser? get currentUser => null;

  @override
  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    throw AuthFailure(_reason, code: 'auth_unavailable');
  }

  @override
  Future<AuthUser> registerWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    throw AuthFailure(_reason, code: 'auth_unavailable');
  }

  @override
  Future<void> sendEmailVerification() async {}

  @override
  Future<void> reloadUser() async {}

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    throw AuthFailure(_reason, code: 'auth_unavailable');
  }

  @override
  Future<void> signOut() async {}
}
