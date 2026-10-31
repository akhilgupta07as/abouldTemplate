import 'package:abould_ada/core/di/providers.dart';
import 'package:abould_ada/core/localization/l10n_extensions.dart';
import 'package:abould_ada/core/routing/route_names.dart';
import 'package:abould_ada/modules/authentication/presentation/utils/auth_sign_out.dart';
import 'package:abould_ada/core/theme/app_colors.dart';
import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_card.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_icon_tile.dart';
import 'package:abould_ada/features/dashboard/presentation/widgets/dashboard_firebase_panel.dart';
import 'package:abould_ada/modules/firebase/di/firebase_providers.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_locale_toggle.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(firebaseAnalyticsServiceProvider).logScreenView(
            screenName: 'dashboard',
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(appConfigProvider);
    final api = ref.watch(dioApiClientProvider);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.subtleGradient(context),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.sm,
                    AppSpacing.lg,
                    0,
                  ),
                  child: Row(
                    children: [
                      const Expanded(child: AdaLocaleToggle()),
                      IconButton(
                        tooltip: context.l10n.signOut,
                        onPressed: () => confirmAndSignOut(ref, context),
                        icon: const Icon(Icons.logout_rounded),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    0,
                    AppSpacing.lg,
                    AppSpacing.sm,
                  ),
                  child: AdaCard(
                    gradient: AppColors.brandGradient,
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.dashboard_customize_rounded,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.22),
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.35),
                                ),
                              ),
                              child: Text(
                                config.environment.label.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          context.l10n.dashboardStarterTitle,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          context.l10n.dashboardStarterSubtitle,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white.withValues(alpha: 0.92),
                                height: 1.4,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.sm,
                    AppSpacing.lg,
                    AppSpacing.lg,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AdaCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.cloud_outlined, color: scheme.primary),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                context.l10n.dashboardApi,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                api.baseUrl,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: scheme.onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: AdaCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.verified_outlined,
                                  color: AppColors.success),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                context.l10n.dashboardStatus,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                context.l10n.dashboardStatusReady,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: scheme.onSurfaceVariant,
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
              const SliverToBoxAdapter(child: DashboardFirebasePanel()),
              SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.lg),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                sliver: SliverToBoxAdapter(
                  child: AdaSectionTitle(
                    title: context.l10n.dashboardPlatformModules,
                    subtitle: context.l10n.dashboardTapModule,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppSpacing.md,
                    crossAxisSpacing: AppSpacing.md,
                    childAspectRatio: 1.05,
                  ),
                  delegate: SliverChildListDelegate([
                    AdaIconTile(
                      icon: Icons.lock_outline_rounded,
                      title: context.l10n.tileAuthentication,
                      subtitle: context.l10n.tileAuthenticationSub,
                      color: AppColors.primary,
                      onTap: () => context.push(RouteNames.authDemo),
                    ),
                    AdaIconTile(
                      icon: Icons.api_rounded,
                      title: context.l10n.tileApiIntegration,
                      subtitle: context.l10n.tileApiIntegrationSub,
                      color: AppColors.secondary,
                      onTap: () => context.push(RouteNames.products),
                    ),
                    AdaIconTile(
                      icon: Icons.http_rounded,
                      title: context.l10n.tileHttpVerbs,
                      subtitle: context.l10n.tileHttpVerbsSub,
                      color: AppColors.primary,
                      onTap: () => context.push(RouteNames.apiHttpDemo),
                    ),
                    AdaIconTile(
                      icon: Icons.local_fire_department_outlined,
                      title: context.l10n.tileFirestoreTodos,
                      subtitle: context.l10n.tileFirestoreTodosSub,
                      color: const Color(0xFFFF9800),
                      onTap: () => context.push(RouteNames.firebaseCrudDemo),
                    ),
                    AdaIconTile(
                      icon: Icons.storage_rounded,
                      title: context.l10n.tileSupabase,
                      subtitle: context.l10n.tileSupabaseSub,
                      color: AppColors.cyan500,
                      onTap: () => context.push(RouteNames.supabaseDemo),
                    ),
                    AdaIconTile(
                      icon: Icons.widgets_outlined,
                      title: context.l10n.tileUiComponents,
                      subtitle: context.l10n.tileUiComponentsSub,
                      color: const Color(0xFFEC4899),
                      onTap: () => context.push(RouteNames.uiShowcase),
                    ),
                    const AdaIconTile(
                      icon: Icons.notifications_active_outlined,
                      title: 'Notifications',
                      subtitle: 'Push & in-app alerts',
                      color: Color(0xFF0891B2),
                    ),
                  ]),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.lg),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
