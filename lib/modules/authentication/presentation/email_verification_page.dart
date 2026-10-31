import 'package:abould_ada/core/localization/l10n_extensions.dart';
import 'package:abould_ada/core/routing/route_names.dart';
import 'package:abould_ada/core/theme/app_colors.dart';
import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:abould_ada/modules/authentication/domain/auth_exception.dart';
import 'package:abould_ada/modules/authentication/presentation/providers/auth_providers.dart';
import 'package:abould_ada/modules/authentication/presentation/utils/auth_messages.dart';
import 'package:abould_ada/modules/authentication/presentation/widgets/auth_page_shell.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_card.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EmailVerificationPage extends ConsumerStatefulWidget {
  const EmailVerificationPage({super.key, this.email});

  final String? email;

  @override
  ConsumerState<EmailVerificationPage> createState() =>
      _EmailVerificationPageState();
}

class _EmailVerificationPageState extends ConsumerState<EmailVerificationPage> {
  bool _resending = false;
  bool _checking = false;

  Future<void> _resend() async {
    setState(() => _resending = true);
    try {
      await ref.read(authRepositoryProvider).sendEmailVerification();
      if (mounted) {
        AuthMessages.showSuccess(context, context.l10n.verificationEmailSentAgain);
      }
    } on AuthFailure catch (e) {
      if (mounted) AuthMessages.showError(context, e.message);
    } finally {
      if (mounted) setState(() => _resending = false);
    }
  }

  Future<void> _checkVerified() async {
    setState(() => _checking = true);
    try {
      await ref.read(authRepositoryProvider).reloadUser();
      final user = ref.read(authRepositoryProvider).currentUser;
      if (!mounted) return;
      if (user?.emailVerified ?? false) {
        AuthMessages.showSuccess(context, context.l10n.emailVerifiedSuccess);
        context.go(RouteNames.dashboard);
      } else {
        AuthMessages.showError(
          context,
          context.l10n.emailNotVerifiedYet,
        );
      }
    } finally {
      if (mounted) setState(() => _checking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = widget.email ?? 'your inbox';

    return AuthPageShell(
      title: context.l10n.verifyEmailTitle,
      subtitle: context.l10n.verifyEmailSubtitle(email),
      child: AdaCard(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.mark_email_unread_outlined,
                size: 48,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              context.l10n.verifyEmailCheckInbox,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              context.l10n.verifyEmailInstructions,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    height: 1.45,
                  ),
            ),
            const SizedBox(height: AppSpacing.xl),
            AdaLoadingButton(
              label: context.l10n.emailVerifiedButton,
              icon: Icons.check_circle_outline,
              isLoading: _checking,
              onPressed: _checkVerified,
            ),
            const SizedBox(height: AppSpacing.sm),
            AdaLoadingButton(
              label: context.l10n.resendEmail,
              isLoading: _resending,
              onPressed: _resend,
            ),
            const SizedBox(height: AppSpacing.md),
            TextButton(
              onPressed: () => context.go(RouteNames.login),
              child: Text(context.l10n.backToSignIn),
            ),
          ],
        ),
      ),
    );
  }
}
