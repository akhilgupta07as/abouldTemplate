import 'package:abould_ada/core/localization/l10n_extensions.dart';
import 'package:abould_ada/core/theme/app_colors.dart';
import 'package:abould_ada/features/profile/presentation/widgets/profile_lifecycle_panel.dart';
import 'package:abould_ada/features/profile/presentation/widgets/profile_location_panel.dart';
import 'package:abould_ada/modules/authentication/presentation/providers/auth_providers.dart';
import 'package:abould_ada/modules/authentication/presentation/utils/auth_sign_out.dart';
import 'package:abould_ada/core/theme/app_radius.dart';
import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_card.dart';
import 'package:abould_ada/features/profile/presentation/widgets/profile_avatar_upload.dart';
import 'package:abould_ada/modules/ui_components/widgets/empty_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentAuthUserProvider);
    final scheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;
    final displayName = user?.displayName?.isNotEmpty == true
        ? user!.displayName!
        : l10n.demoUser;
    final email = user?.email ?? 'profile@abould.demo';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.subtleGradient(context),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 220,
              pinned: true,
              stretch: true,
              actions: [
                IconButton(
                  tooltip: l10n.signOut,
                  onPressed: () => confirmAndSignOut(ref, context),
                  icon: const Icon(Icons.logout_rounded, color: Colors.white),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [StretchMode.zoomBackground],
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    DecoratedBox(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.gradientStart,
                            AppColors.gradientMid,
                            AppColors.gradientEnd,
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.35),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  width: 3,
                                ),
                              ),
                              child: const ProfileAvatarUpload(),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              displayName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            Text(
                              email,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.9),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  children: [
                    AdaCard(
                      child: Row(
                        children: [
                          _StatItem(
                            label: l10n.profileProjects,
                            value: '—',
                            icon: Icons.folder_open_rounded,
                            color: scheme.primary,
                          ),
                          _divider(context),
                          _StatItem(
                            label: l10n.profileTasks,
                            value: '—',
                            icon: Icons.task_alt_rounded,
                            color: AppColors.secondary,
                          ),
                          _divider(context),
                          _StatItem(
                            label: l10n.profileAlerts,
                            value: '0',
                            icon: Icons.notifications_none_rounded,
                            color: AppColors.accent,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AdaCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.accountSettings,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          _SettingsRow(
                            icon: Icons.edit_outlined,
                            title: l10n.editProfile,
                            subtitle: l10n.editProfileSubtitle,
                          ),
                          _SettingsRow(
                            icon: Icons.security_outlined,
                            title: l10n.securityTitle,
                            subtitle: l10n.securitySubtitle,
                          ),
                          _SettingsRow(
                            icon: Icons.palette_outlined,
                            title: l10n.appearanceTitle,
                            subtitle: l10n.appearanceSubtitle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const ProfileLocationPanel(),
                    const SizedBox(height: AppSpacing.md),
                    const ProfileLifecyclePanel(),
                    const SizedBox(height: AppSpacing.xl),
                    EmptyView(
                      title: user?.emailVerified == true
                          ? l10n.profileReadyTitle
                          : l10n.verifyEmailProfileTitle,
                      message: user?.emailVerified == true
                          ? l10n.profileReadyMessage
                          : l10n.verifyEmailProfileMessage,
                      icon: user?.emailVerified == true
                          ? Icons.verified_user_outlined
                          : Icons.mark_email_unread_outlined,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider(BuildContext context) {
    return Container(
      width: 1,
      height: 48,
      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.15),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(icon, size: 20),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
