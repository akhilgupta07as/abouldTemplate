import 'package:abould_ada/core/localization/l10n_extensions.dart';
import 'package:abould_ada/core/routing/route_names.dart';
import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:abould_ada/modules/authentication/domain/auth_exception.dart';
import 'package:abould_ada/modules/authentication/presentation/providers/auth_providers.dart';
import 'package:abould_ada/modules/authentication/presentation/utils/auth_messages.dart';
import 'package:abould_ada/modules/authentication/presentation/utils/auth_validators.dart';
import 'package:abould_ada/modules/authentication/presentation/widgets/auth_page_shell.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_card.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_loading_button.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() =>
      _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _loading = true);
    try {
      await ref
          .read(authRepositoryProvider)
          .sendPasswordResetEmail(_emailController.text);
      if (!mounted) return;
      AuthMessages.showSuccess(
        context,
        context.l10n.passwordResetEmailSent,
      );
      context.go(RouteNames.login);
    } on AuthFailure catch (e) {
      if (mounted) AuthMessages.showError(context, e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageShell(
      title: context.l10n.forgotPasswordTitle,
      subtitle: context.l10n.forgotPasswordInstructions,
      child: AdaCard(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AdaTextField(
                controller: _emailController,
                label: context.l10n.labelEmail,
                hint: context.l10n.hintEmailWork,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                prefixIcon: Icons.mail_outline_rounded,
                validator: AuthValidators.email,
              ),
              const SizedBox(height: AppSpacing.lg),
              AdaLoadingButton(
                label: context.l10n.sendResetLink,
                icon: Icons.send_rounded,
                isLoading: _loading,
                onPressed: _submit,
              ),
              const SizedBox(height: AppSpacing.sm),
              TextButton(
                onPressed: () => context.go(RouteNames.login),
                child: Text(context.l10n.backToSignIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
