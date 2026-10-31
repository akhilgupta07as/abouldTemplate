import 'package:abould_ada/core/di/providers.dart';
import 'package:abould_ada/core/routing/route_names.dart';
import 'package:abould_ada/modules/authentication/presentation/providers/auth_providers.dart';
import 'package:abould_ada/modules/ui_components/widgets/feedback/ada_dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Shows confirmation, then signs out and navigates to login.
Future<void> confirmAndSignOut(WidgetRef ref, BuildContext context) async {
  final confirmed = await AdaDialogs.confirmSignOut(context);
  if (!confirmed) return;

  await signOutCompletely(ref);
  if (context.mounted) {
    context.go(RouteNames.login);
  }
}

/// Signs out app auth and clears Firebase Auth when the SDK is enabled.
Future<void> signOutCompletely(WidgetRef ref) async {
  await ref.read(authRepositoryProvider).signOut();
  await ref.clearAuthSession();

  if (ref.read(appConfigProvider).useFirebase) {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (_) {}
  }
}
