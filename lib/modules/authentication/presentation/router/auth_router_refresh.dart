import 'package:abould_ada/modules/authentication/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRouterRefresh extends ChangeNotifier {
  AuthRouterRefresh(this._ref) {
    _ref.listen(authStateProvider, (previous, next) => notifyListeners());
  }

  final Ref _ref;
}

final authRouterRefreshProvider = Provider<AuthRouterRefresh>((ref) {
  final notifier = AuthRouterRefresh(ref);
  ref.onDispose(notifier.dispose);
  return notifier;
});
