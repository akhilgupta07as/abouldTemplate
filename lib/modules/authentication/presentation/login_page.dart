import 'package:abould_ada/core/config/auth_backend.dart';
import 'package:abould_ada/core/di/providers.dart';
import 'package:abould_ada/core/localization/l10n_extensions.dart';
import 'package:abould_ada/core/routing/route_names.dart';
import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:abould_ada/modules/authentication/domain/auth_exception.dart';
import 'package:abould_ada/modules/authentication/presentation/providers/auth_providers.dart';
import 'package:abould_ada/modules/authentication/presentation/utils/auth_messages.dart';
import 'package:abould_ada/modules/authentication/presentation/utils/auth_validators.dart';
import 'package:abould_ada/modules/authentication/presentation/widgets/auth_link_row.dart';
import 'package:abould_ada/modules/authentication/presentation/widgets/auth_method_selector.dart';
import 'package:abould_ada/modules/authentication/presentation/widgets/auth_page_shell.dart';
import 'package:abould_ada/modules/firebase/di/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_card.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_loading_button.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_password_field.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'emilys');
  final _passwordController = TextEditingController(text: 'emilyspass');
  bool _loading = false;
  bool _rememberMe = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  AuthBackend get _method => ref.watch(loginAuthBackendProvider);

  bool get _isApiLogin => _method == AuthBackend.dummyJson;

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _loading = true);
    try {
      final backend = ref.read(loginAuthBackendProvider);
      await ref.persistLoginPreference(backend);
      await ref.persistAuthSessionBackend(backend);

      await ref.read(authRepositoryProvider).signInWithEmail(
            email: _usernameController.text,
            password: _passwordController.text,
          );

      final config = ref.read(appConfigProvider);
      if (config.useFirebase && backend == AuthBackend.firebase) {
        await ref
            .read(firebaseAnalyticsServiceProvider)
            .logLogin(method: 'firebase');
      } else if (config.useFirebase) {
        // Avoid stale Firebase Auth causing Firestore listens while on API session.
        try {
          await FirebaseAuth.instance.signOut();
        } catch (_) {}
      }

      if (!mounted) return;
      context.go(RouteNames.dashboard);
    } on AuthFailure catch (e) {
      await ref.clearAuthSession();
      if (mounted) AuthMessages.showError(context, e.message);
    } catch (_) {
      await ref.clearAuthSession();
      if (mounted) {
        AuthMessages.showError(context, context.l10n.signInFailed);
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _subtitle(AuthBackend method) {
    return switch (method) {
      AuthBackend.dummyJson => context.l10n.loginSubtitleApi,
      AuthBackend.firebase => context.l10n.loginSubtitleFirebase,
      AuthBackend.supabase => context.l10n.loginSubtitleSupabase,
    };
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(appConfigProvider);
    final method = _method;

    return AuthPageShell(
      title: context.l10n.welcomeBack,
      subtitle: _subtitle(method),
      showBackButton: false,
      footer: AuthLinkRow(
        prompt: context.l10n.newToAda,
        actionLabel: context.l10n.createAccountLink,
        onTap: () => context.push(RouteNames.register),
      ),
      child: AdaCard(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthMethodSelector(
                options: loginAuthBackendOptions,
                selected: method,
                onSelected: (backend) {
                  ref.read(loginAuthBackendProvider.notifier).state = backend;
                  ref.persistLoginPreference(backend);
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              AdaTextField(
                controller: _usernameController,
                label: _isApiLogin
                    ? context.l10n.labelUsername
                    : context.l10n.labelEmail,
                hint: _isApiLogin
                    ? context.l10n.hintUsernameApi
                    : context.l10n.hintEmailWork,
                keyboardType: _isApiLogin
                    ? TextInputType.text
                    : TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                prefixIcon: Icons.person_outline_rounded,
                validator:
                    _isApiLogin ? AuthValidators.username : AuthValidators.email,
              ),
              const SizedBox(height: AppSpacing.md),
              AdaPasswordField(
                controller: _passwordController,
                label: context.l10n.password,
                hint: context.l10n.passwordHintEnter,
                textInputAction: TextInputAction.done,
                validator: AuthValidators.password,
                onSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (v) => setState(() => _rememberMe = v ?? true),
                  ),
                  Text(context.l10n.rememberMe),
                  if (!_isApiLogin) ...[
                    const Spacer(),
                    TextButton(
                      onPressed: () => context.push(RouteNames.forgotPassword),
                      child: Text(context.l10n.forgotPasswordTitle),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              AdaLoadingButton(
                label: context.l10n.signIn,
                icon: Icons.login_rounded,
                isLoading: _loading,
                onPressed: _submit,
              ),
              if (_isApiLogin) ...[
                const SizedBox(height: AppSpacing.md),
                Text(
                  'API: ${config.apiBaseUrl}/auth/login',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
              if (method == AuthBackend.supabase) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  context.l10n.loginSupabaseRegNote,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
