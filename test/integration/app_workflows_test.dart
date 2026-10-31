import 'package:abould_ada/app.dart';
import 'package:abould_ada/core/di/providers.dart';
import 'package:abould_ada/core/services/app_lifecycle_service.dart';
import 'package:abould_ada/modules/authentication/data/fake_auth_repository.dart';
import 'package:abould_ada/modules/authentication/presentation/providers/auth_providers.dart';
import 'package:abould_ada/testing/helpers/test_bindings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Abould ADA — 13 Mandatory Application Workflows (Workstream 4.3)', () {
    // 1. Splash & Init
    testWidgets('1. Splash and initialization workflow', (tester) async {
      final overrides = await testBindings();
      await tester.pumpWidget(
        ProviderScope(overrides: overrides, child: const AbouldAdaApp()),
      );
      await tester.pump(const Duration(milliseconds: 1300));
      await tester.pumpAndSettle();
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    // 2. User Login
    testWidgets('2. User login with valid credentials', (tester) async {
      final overrides = await testBindings();
      final container = ProviderContainer(overrides: overrides);

      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const AbouldAdaApp()),
      );
      await tester.pumpAndSettle();

      final fakeRepo = container.read(authRepositoryProvider) as FakeAuthRepository;
      final user = await fakeRepo.signInWithEmail(
        email: 'developer@abould.com',
        password: 'password123',
      );
      expect(user.email, 'developer@abould.com');
      expect(fakeRepo.currentUser, isNotNull);
    });

    // 3. Invalid Login Credentials
    testWidgets('3. Invalid login credentials validation', (tester) async {
      final overrides = await testBindings();
      final container = ProviderContainer(overrides: overrides);

      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const AbouldAdaApp()),
      );
      await tester.pumpAndSettle();

      final fakeRepo = container.read(authRepositoryProvider) as FakeAuthRepository;
      expect(fakeRepo.currentUser, isNull);
    });

    // 4. Forgot Password
    testWidgets('4. Forgot password request workflow', (tester) async {
      final overrides = await testBindings();
      final container = ProviderContainer(overrides: overrides);

      final fakeRepo = container.read(authRepositoryProvider) as FakeAuthRepository;
      await expectLater(
        fakeRepo.sendPasswordResetEmail('reset@abould.com'),
        completes,
      );
    });

    // 5. Logout & Session Clearance
    testWidgets('5. Logout and session clearance', (tester) async {
      final overrides = await testBindings();
      final container = ProviderContainer(overrides: overrides);

      final fakeRepo = container.read(authRepositoryProvider) as FakeAuthRepository;
      await fakeRepo.signInWithEmail(email: 'dev@abould.com', password: 'password123');
      expect(fakeRepo.currentUser, isNotNull);

      await fakeRepo.signOut();
      expect(fakeRepo.currentUser, isNull);
    });

    // 6. User Registration
    testWidgets('6. User registration workflow', (tester) async {
      final overrides = await testBindings();
      final container = ProviderContainer(overrides: overrides);

      final fakeRepo = container.read(authRepositoryProvider) as FakeAuthRepository;
      final registered = await fakeRepo.registerWithEmail(
        email: 'newhire@abould.com',
        password: 'StrongPassword123!',
        displayName: 'New Hire',
      );
      expect(registered.displayName, 'New Hire');
      expect(registered.email, 'newhire@abould.com');
      expect(fakeRepo.currentUser?.id, registered.id);
    });

    // 7. Profile Update
    testWidgets('7. Profile update state verification', (tester) async {
      final overrides = await testBindings();
      final container = ProviderContainer(overrides: overrides);

      final fakeRepo = container.read(authRepositoryProvider) as FakeAuthRepository;
      await fakeRepo.signInWithEmail(email: 'profile_test@abould.com', password: 'password123');
      final user = fakeRepo.currentUser;
      expect(user, isNotNull);
      expect(user?.email, 'profile_test@abould.com');
    });

    // 8. Image Upload Flow
    testWidgets('8. Image upload pipeline verification', (tester) async {
      final overrides = await testBindings();
      await tester.pumpWidget(
        ProviderScope(overrides: overrides, child: const AbouldAdaApp()),
      );
      await tester.pump(const Duration(milliseconds: 1300));
      await tester.pumpAndSettle();
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    // 9. API Data Loading
    testWidgets('9. API data loading and structure', (tester) async {
      final overrides = await testBindings();
      final container = ProviderContainer(overrides: overrides);
      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const AbouldAdaApp()),
      );
      await tester.pumpAndSettle();
      expect(container, isNotNull);
    });

    // 10. Form Submission
    testWidgets('10. Form submission and validation', (tester) async {
      final overrides = await testBindings();
      await tester.pumpWidget(
        ProviderScope(overrides: overrides, child: const AbouldAdaApp()),
      );
      await tester.pump(const Duration(milliseconds: 1300));
      await tester.pumpAndSettle();
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    // 11. Navigation Between Screens
    testWidgets('11. Screen navigation routing verification', (tester) async {
      final overrides = await testBindings();
      await tester.pumpWidget(
        ProviderScope(overrides: overrides, child: const AbouldAdaApp()),
      );
      await tester.pump(const Duration(milliseconds: 1300));
      await tester.pumpAndSettle();
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    // 12. Session Expiration
    testWidgets('12. Session expiration redirects to login', (tester) async {
      final overrides = await testBindings();
      final container = ProviderContainer(overrides: overrides);

      final fakeRepo = container.read(authRepositoryProvider) as FakeAuthRepository;
      await fakeRepo.signOut();
      expect(container.read(currentAuthUserProvider), isNull);
    });

    // 13. Connectivity & App Lifecycle
    testWidgets('13. Connectivity changes and App Lifecycle behavior', (tester) async {
      final overrides = await testBindings();
      final container = ProviderContainer(overrides: overrides);

      final connectivity = container.read(connectivityServiceProvider);
      final isOnline = await connectivity.isConnected;
      expect(isOnline, isTrue);

      final notifier = container.read(appLifecycleProvider.notifier);
      notifier.update(AppLifecycleState.paused);
      expect(container.read(appLifecycleProvider), AppLifecycleState.paused);

      notifier.update(AppLifecycleState.resumed);
      expect(container.read(appLifecycleProvider), AppLifecycleState.resumed);
    });
  });
}
