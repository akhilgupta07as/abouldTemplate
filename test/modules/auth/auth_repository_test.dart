import 'package:abould_ada/modules/authentication/data/fake_auth_repository.dart';
import 'package:abould_ada/modules/authentication/domain/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthUser & FakeAuthRepository', () {
    test('AuthUser equality and props', () {
      const user1 = AuthUser(id: '123', email: 'test@example.com', displayName: 'Tester');
      const user2 = AuthUser(id: '123', email: 'test@example.com', displayName: 'Tester');
      const user3 = AuthUser(id: '456', email: 'other@example.com');

      expect(user1, equals(user2));
      expect(user1 == user3, isFalse);
    });

    test('FakeAuthRepository lifecycle: login, state stream, logout', () async {
      final repo = FakeAuthRepository();

      // Initial user is null
      expect(repo.currentUser, isNull);

      // Sign in
      final user = await repo.signInWithEmail(email: 'demo@abould.com', password: 'password123');
      expect(user.email, 'demo@abould.com');
      expect(repo.currentUser, isNotNull);
      expect(repo.currentUser?.id, user.id);

      // Sign out
      await repo.signOut();
      expect(repo.currentUser, isNull);
    });

    test('FakeAuthRepository registration and password reset', () async {
      final repo = FakeAuthRepository();
      final user = await repo.registerWithEmail(
        email: 'newuser@abould.com',
        password: 'password123',
        displayName: 'New Developer',
      );

      expect(user.displayName, 'New Developer');
      expect(user.email, 'newuser@abould.com');

      // Reset password succeeds without throw
      await expectLater(
        repo.sendPasswordResetEmail('newuser@abould.com'),
        completes,
      );
    });
  });
}
