import 'package:abould_ada/modules/authentication/data/firebase_auth_mapper.dart';
import 'package:abould_ada/modules/authentication/domain/auth_exception.dart';
import 'package:abould_ada/modules/authentication/domain/auth_repository.dart';
import 'package:abould_ada/modules/authentication/domain/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth);

  final FirebaseAuth _auth;

  @override
  Stream<AuthUser?> authStateChanges() {
    return _auth.authStateChanges().map(FirebaseAuthMapper.fromFirebaseUser);
  }

  @override
  AuthUser? get currentUser =>
      FirebaseAuthMapper.fromFirebaseUser(_auth.currentUser);

  @override
  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = FirebaseAuthMapper.fromFirebaseUser(credential.user);
      if (user == null) {
        throw const AuthFailure('Sign in failed. Please try again.');
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthMapper.mapException(e);
    }
  }

  @override
  Future<AuthUser> registerWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw const AuthFailure('Registration failed. Please try again.');
      }
      if (displayName != null && displayName.trim().isNotEmpty) {
        await firebaseUser.updateDisplayName(displayName.trim());
        await firebaseUser.reload();
      }
      await firebaseUser.sendEmailVerification();
      final user = FirebaseAuthMapper.fromFirebaseUser(_auth.currentUser);
      if (user == null) {
        throw const AuthFailure('Registration failed. Please try again.');
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthMapper.mapException(e);
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw const AuthFailure('You are not signed in.');
    }
    try {
      await user.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthMapper.mapException(e);
    }
  }

  @override
  Future<void> reloadUser() async {
    await _auth.currentUser?.reload();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthMapper.mapException(e);
    }
  }

  @override
  Future<void> signOut() => _auth.signOut();
}
