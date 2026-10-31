import 'package:abould_ada/core/config/auth_backend.dart';
import 'package:abould_ada/core/localization/l10n_extensions.dart';
import 'package:abould_ada/core/routing/route_names.dart';
import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:abould_ada/modules/authentication/domain/auth_exception.dart';
import 'package:abould_ada/modules/authentication/presentation/providers/auth_providers.dart';
import 'package:abould_ada/modules/supabase/di/supabase_crud_providers.dart';
import 'package:abould_ada/modules/supabase/di/supabase_providers.dart';
import 'package:abould_ada/modules/authentication/presentation/utils/auth_messages.dart';
import 'package:abould_ada/modules/authentication/presentation/utils/auth_validators.dart';
import 'package:abould_ada/modules/authentication/presentation/widgets/auth_link_row.dart';
import 'package:abould_ada/modules/authentication/presentation/widgets/auth_method_selector.dart';
import 'package:abould_ada/modules/authentication/presentation/widgets/auth_page_shell.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_card.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_loading_button.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_password_field.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _loading = false;
  bool _acceptedTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.acceptTermsPrompt)),
      );
      return;
    }

    setState(() => _loading = true);
    try {
      final backend = ref.read(registrationAuthBackendProvider);
      await ref.persistAuthSessionBackend(backend);

      final user = await ref.read(authRepositoryProvider).registerWithEmail(
            email: _emailController.text,
            password: _passwordController.text,
            displayName: _nameController.text,
          );
      if (!mounted) return;
      if (backend == AuthBackend.supabase) {
        if (ref.read(supabaseReadyProvider)) {
          try {
            await ref.read(supabaseProfilesRepositoryProvider).ensureProfile(
                  userId: user.id,
                  email: user.email,
                  fullName: _nameController.text,
                );
          } catch (_) {}
        }
        if (!mounted) return;
        if (user.emailVerified) {
          context.go(RouteNames.dashboard);
          return;
        }
      }
      if (!mounted) return;
      if (backend == AuthBackend.firebase) {
        final email = Uri.encodeComponent(_emailController.text.trim());
        context.push('${RouteNames.verifyEmail}?email=$email');
        return;
      }
      context.go(RouteNames.dashboard);
    } on AuthFailure catch (e) {
      await ref.clearAuthSession();
      if (mounted) AuthMessages.showError(context, e.message);
    } catch (_) {
      await ref.clearAuthSession();
      if (mounted) {
        AuthMessages.showError(context, context.l10n.registrationFailed);
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final method = ref.watch(registrationAuthBackendProvider);

    return AuthPageShell(
      title: context.l10n.createAccount,
      subtitle: context.l10n.registerSubtitle,
      footer: AuthLinkRow(
        prompt: context.l10n.alreadyHaveAccount,
        actionLabel: context.l10n.signIn,
        onTap: () => context.go(RouteNames.login),
      ),
      child: AdaCard(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthMethodSelector(
                title: context.l10n.registerWith,
                options: registrationAuthBackendOptions,
                selected: method,
                onSelected: (backend) {
                  ref.read(registrationAuthBackendProvider.notifier).state =
                      backend;
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              AdaTextField(
                controller: _nameController,
                label: context.l10n.fullName,
                hint: context.l10n.hintFullName,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.name],
                prefixIcon: Icons.person_outline_rounded,
                validator: AuthValidators.name,
              ),
              const SizedBox(height: AppSpacing.md),
              AdaTextField(
                controller: _emailController,
                label: context.l10n.workEmail,
                hint: context.l10n.hintEmailWork,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                prefixIcon: Icons.mail_outline_rounded,
                validator: AuthValidators.email,
              ),
              const SizedBox(height: AppSpacing.md),
              AdaTextField(
                controller: _phoneController,
                label: context.l10n.phoneOptional,
                hint: context.l10n.hintPhoneIndia,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9+\s-]')),
                ],
                prefixIcon: Icons.phone_outlined,
              ),
              const SizedBox(height: AppSpacing.md),
              AdaPasswordField(
                controller: _passwordController,
                label: context.l10n.password,
                hint: context.l10n.passwordHintMin,
                textInputAction: TextInputAction.next,
                validator: AuthValidators.password,
              ),
              const SizedBox(height: AppSpacing.md),
              AdaPasswordField(
                controller: _confirmPasswordController,
                label: context.l10n.confirmPassword,
                textInputAction: TextInputAction.done,
                validator: (v) => AuthValidators.confirmPassword(
                  v,
                  _passwordController.text,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _acceptedTerms,
                    onChanged: (v) =>
                        setState(() => _acceptedTerms = v ?? false),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        context.l10n.termsAgreement,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              AdaLoadingButton(
                label: context.l10n.createAccountButton,
                icon: Icons.person_add_alt_1_rounded,
                isLoading: _loading,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
