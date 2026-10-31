import 'package:abould_ada/core/routing/route_names.dart';
import 'package:abould_ada/core/theme/app_colors.dart';
import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:abould_ada/modules/authentication/presentation/providers/auth_providers.dart';
import 'package:abould_ada/modules/authentication/presentation/utils/auth_sign_out.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_card.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_status_chip.dart';
import 'package:abould_ada/modules/ui_components/widgets/buttons/ada_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Hub for previewing auth flows without fighting logged-in redirects.
class AuthDemoPage extends ConsumerWidget {
  const AuthDemoPage({super.key});

  static const previewQuery = 'preview=true';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentAuthUserProvider);
    final sessionBackend = ref.watch(authSessionBackendProvider);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Authentication')),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.subtleGradient(context),
        ),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            AdaCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lock_outline_rounded, color: scheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        'Session',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (user != null) ...[
                    Text(
                      user.email,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    if (user.displayName != null) Text(user.displayName!),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (sessionBackend != null)
                          AdaStatusChip(
                            label: sessionBackend.label,
                            color: AppColors.primary,
                          ),
                        AdaStatusChip(
                          label: user.emailVerified ? 'Verified' : 'Unverified',
                          color: user.emailVerified
                              ? AppColors.success
                              : AppColors.warning,
                        ),
                      ],
                    ),
                  ] else
                    Text(
                      'Not signed in',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Firebase, Supabase, and DummyJSON API backends. '
                    'Preview screens below without leaving the app shell.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                          height: 1.45,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AdaCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Preview auth UI',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AdaPrimaryButton(
                    label: 'Login screen',
                    icon: Icons.login_rounded,
                    onPressed: () => context.push(
                      '${RouteNames.login}?$previewQuery',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AdaOutlinedButton(
                    label: 'Create account',
                    icon: Icons.person_add_alt_1_outlined,
                    onPressed: () => context.push(
                      '${RouteNames.register}?$previewQuery',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AdaOutlinedButton(
                    label: 'Forgot password',
                    icon: Icons.lock_reset_outlined,
                    onPressed: () => context.push(
                      '${RouteNames.forgotPassword}?$previewQuery',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AdaOutlinedButton(
                    label: 'Verify email (demo)',
                    onPressed: () => context.push(
                      '${RouteNames.verifyEmail}?email=demo@ada.app&$previewQuery',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AdaCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Quick sign-in',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AdaOutlinedButton(
                    label: 'Open login · Supabase',
                    onPressed: () {
                      ref.read(loginAuthBackendProvider.notifier).state =
                          AuthBackend.supabase;
                      context.push('${RouteNames.login}?$previewQuery');
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AdaOutlinedButton(
                    label: 'Open login · Firebase',
                    onPressed: () {
                      ref.read(loginAuthBackendProvider.notifier).state =
                          AuthBackend.firebase;
                      context.push('${RouteNames.login}?$previewQuery');
                    },
                  ),
                  if (user != null) ...[
                    const SizedBox(height: AppSpacing.lg),
                    AdaOutlinedButton(
                      label: 'Sign out',
                      icon: Icons.logout_rounded,
                      onPressed: () => confirmAndSignOut(ref, context),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
