import 'package:abould_ada/core/localization/l10n_extensions.dart';
import 'package:abould_ada/core/routing/route_names.dart';
import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:abould_ada/modules/authentication/presentation/utils/auth_validators.dart';
import 'package:abould_ada/modules/authentication/presentation/widgets/auth_page_shell.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_card.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_loading_button.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_password_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key, this.email});

  final String? email;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _loading = true);
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.passwordUpdatedSuccess)),
    );
    context.go(RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    final email = widget.email;

    return AuthPageShell(
      title: context.l10n.setNewPasswordTitle,
      subtitle: email != null && email.isNotEmpty
          ? context.l10n.resetPasswordSubtitleEmail(email)
          : context.l10n.resetPasswordSubtitleGeneric,
      child: AdaCard(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AdaPasswordField(
                controller: _passwordController,
                label: context.l10n.newPassword,
                validator: AuthValidators.password,
              ),
              const SizedBox(height: AppSpacing.md),
              AdaPasswordField(
                controller: _confirmController,
                label: context.l10n.confirmNewPassword,
                validator: (v) => AuthValidators.confirmPassword(
                  v,
                  _passwordController.text,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              AdaLoadingButton(
                label: context.l10n.updatePassword,
                icon: Icons.check_circle_outline,
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
