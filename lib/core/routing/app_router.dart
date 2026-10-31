import 'package:abould_ada/core/routing/route_names.dart';
import 'package:abould_ada/features/dashboard/presentation/dashboard_page.dart';
import 'package:abould_ada/features/profile/presentation/profile_page.dart';
import 'package:abould_ada/features/splash/presentation/splash_page.dart';
import 'package:abould_ada/features/api_demo/presentation/api_http_demo_page.dart';
import 'package:abould_ada/features/firebase_crud/presentation/firebase_crud_demo_page.dart';
import 'package:abould_ada/features/auth_demo/presentation/auth_demo_page.dart';
import 'package:abould_ada/features/supabase_demo/presentation/supabase_demo_page.dart';
import 'package:abould_ada/features/products/presentation/products_page.dart';
import 'package:abould_ada/features/ui_showcase/presentation/ui_showcase_page.dart';
import 'package:abould_ada/modules/authentication/presentation/email_verification_page.dart';
import 'package:abould_ada/modules/authentication/presentation/forgot_password_page.dart';
import 'package:abould_ada/modules/authentication/presentation/login_page.dart';
import 'package:abould_ada/modules/authentication/presentation/otp_verification_page.dart';
import 'package:abould_ada/modules/authentication/presentation/providers/auth_providers.dart';
import 'package:abould_ada/modules/authentication/presentation/register_page.dart';
import 'package:abould_ada/modules/authentication/presentation/reset_password_page.dart';
import 'package:abould_ada/modules/authentication/presentation/router/auth_router_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  final refresh = ref.watch(authRouterRefreshProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: false,
    refreshListenable: refresh,
    redirect: (context, state) {
      final authAsync = ref.read(authStateProvider);
      if (authAsync.isLoading) {
        return pathIsProtected(state.uri.path) ? RouteNames.splash : null;
      }

      final user = authAsync.valueOrNull;
      final loggedIn = user != null;
      final path = state.uri.path;

      if (path == RouteNames.splash) {
        return null;
      }

      final isAuthRoute = RouteNames.authRoutes.contains(path);

      if (!loggedIn && !isAuthRoute) {
        return RouteNames.login;
      }

      if (loggedIn && isAuthRoute && path != RouteNames.verifyEmail) {
        final preview = state.uri.queryParameters['preview'] == 'true';
        if (!preview) {
          return RouteNames.dashboard;
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RouteNames.splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteNames.register,
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        name: 'forgotPassword',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: RouteNames.resetPassword,
        name: 'resetPassword',
        builder: (context, state) {
          final email = state.uri.queryParameters['email'];
          return ResetPasswordPage(email: email);
        },
      ),
      GoRoute(
        path: RouteNames.verifyOtp,
        name: 'verifyOtp',
        builder: (context, state) {
          final email = state.uri.queryParameters['email'];
          final flow = state.uri.queryParameters['flow'] ?? 'signup';
          return OtpVerificationPage(email: email, flow: flow);
        },
      ),
      GoRoute(
        path: RouteNames.verifyEmail,
        name: 'verifyEmail',
        builder: (context, state) {
          final email = state.uri.queryParameters['email'];
          return EmailVerificationPage(email: email);
        },
      ),
      GoRoute(
        path: RouteNames.dashboard,
        name: 'dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: RouteNames.profile,
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: RouteNames.uiShowcase,
        name: 'uiShowcase',
        builder: (context, state) => const UiShowcasePage(),
      ),
      GoRoute(
        path: RouteNames.products,
        name: 'products',
        builder: (context, state) => const ProductsPage(),
      ),
      GoRoute(
        path: RouteNames.apiHttpDemo,
        name: 'apiHttpDemo',
        builder: (context, state) => const ApiHttpDemoPage(),
      ),
      GoRoute(
        path: RouteNames.firebaseCrudDemo,
        name: 'firebaseCrudDemo',
        builder: (context, state) => const FirebaseCrudDemoPage(),
      ),
      GoRoute(
        path: RouteNames.supabaseDemo,
        name: 'supabaseDemo',
        builder: (context, state) => const SupabaseDemoPage(),
      ),
      GoRoute(
        path: RouteNames.authDemo,
        name: 'authDemo',
        builder: (context, state) => const AuthDemoPage(),
      ),
    ],
  );
});

bool pathIsProtected(String path) {
  return path == RouteNames.dashboard ||
      path == RouteNames.profile ||
      path == RouteNames.uiShowcase ||
      path == RouteNames.products ||
      path == RouteNames.apiHttpDemo ||
      path == RouteNames.firebaseCrudDemo ||
      path == RouteNames.supabaseDemo ||
      path == RouteNames.authDemo;
}
