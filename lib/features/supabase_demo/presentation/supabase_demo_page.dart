import 'package:abould_ada/core/di/providers.dart';

import 'package:abould_ada/core/localization/l10n_extensions.dart';

import 'package:abould_ada/core/routing/route_names.dart';

import 'package:abould_ada/core/theme/app_colors.dart';

import 'package:abould_ada/core/theme/app_spacing.dart';

import 'package:abould_ada/features/supabase_demo/presentation/widgets/supabase_tasks_panel.dart';

import 'package:abould_ada/features/supabase_demo/presentation/widgets/supabase_user_panel.dart';

import 'package:abould_ada/modules/authentication/presentation/providers/auth_providers.dart';

import 'package:abould_ada/modules/supabase/di/supabase_crud_providers.dart';

import 'package:abould_ada/modules/supabase/di/supabase_providers.dart';

import 'package:abould_ada/modules/ui_components/widgets/ada_card.dart';

import 'package:abould_ada/modules/ui_components/widgets/ada_status_chip.dart';

import 'package:abould_ada/modules/ui_components/widgets/buttons/ada_buttons.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';



class SupabaseDemoPage extends ConsumerWidget {

  const SupabaseDemoPage({super.key});



  @override

  Widget build(BuildContext context, WidgetRef ref) {

    final l10n = context.l10n;

    final config = ref.watch(appConfigProvider);

    final ready = ref.watch(supabaseReadyProvider);

    final crudEnabled = ref.watch(supabaseCrudEnabledProvider);

    final sessionBackend = ref.watch(authSessionBackendProvider);

    final user = ref.watch(currentAuthUserProvider);

    final scheme = Theme.of(context).colorScheme;



    final supabaseSession =

        sessionBackend == AuthBackend.supabase && user != null;



    return Scaffold(

      appBar: AppBar(title: Text(l10n.supabaseTitle)),

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

                      Icon(Icons.storage_rounded, color: scheme.primary),

                      const SizedBox(width: 8),

                      Text(

                        l10n.supabaseProjectConnection,

                        style: Theme.of(context).textTheme.titleSmall?.copyWith(

                              fontWeight: FontWeight.w700,

                            ),

                      ),

                    ],

                  ),

                  const SizedBox(height: AppSpacing.md),

                  Wrap(

                    spacing: 8,

                    runSpacing: 8,

                    children: [

                      AdaStatusChip(

                        label: ready

                            ? l10n.supabaseSdkConnected

                            : l10n.supabaseNotInitialized,

                        color: ready ? AppColors.success : AppColors.warning,

                        icon: ready

                            ? Icons.check_circle_outline

                            : Icons.link_off,

                      ),

                      AdaStatusChip(

                        label: config.isSupabaseConfigured

                            ? l10n.supabaseKeysProvided

                            : l10n.supabaseKeysMissing,

                        color: config.isSupabaseConfigured

                            ? AppColors.cyan500

                            : AppColors.error,

                      ),

                      if (crudEnabled)

                        AdaStatusChip(

                          label: l10n.supabaseRealtimeCrud,

                          color: AppColors.cyan500,

                          icon: Icons.bolt,

                        ),

                    ],

                  ),

                  const SizedBox(height: AppSpacing.md),

                  if (config.supabaseUrl.isNotEmpty)

                    Text(

                      '${l10n.urlLabel}: ${config.supabaseUrl}',

                      style: Theme.of(context).textTheme.bodySmall?.copyWith(

                            color: scheme.onSurfaceVariant,

                          ),

                    )

                  else

                    Text(

                      l10n.supabaseUrlMissingConfig,

                      style: Theme.of(context).textTheme.bodySmall?.copyWith(

                            color: scheme.onSurfaceVariant,

                            height: 1.45,

                          ),

                    ),

                  const SizedBox(height: AppSpacing.sm),

                  Text(

                    l10n.supabaseSetupSteps,

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

                    l10n.supabaseAuthSection,

                    style: Theme.of(context).textTheme.titleSmall?.copyWith(

                          fontWeight: FontWeight.w700,

                        ),

                  ),

                  const SizedBox(height: AppSpacing.sm),

                  if (supabaseSession)

                    Text(

                      l10n.supabaseSignedInAs(user.email),

                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(

                            fontWeight: FontWeight.w600,

                          ),

                    )

                  else

                    Text(

                      ready

                          ? l10n.supabaseSignInCrudHint

                          : l10n.supabaseKeysHint,

                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(

                            height: 1.45,

                          ),

                    ),

                  const SizedBox(height: AppSpacing.lg),

                  AdaPrimaryButton(

                    label: l10n.supabaseOpenLogin,

                    onPressed: ready

                        ? () {

                            ref.read(loginAuthBackendProvider.notifier).state =

                                AuthBackend.supabase;

                            context.push(RouteNames.login);

                          }

                        : null,

                  ),

                  const SizedBox(height: AppSpacing.sm),

                  AdaOutlinedButton(

                    label: l10n.supabaseCreateAccount,

                    onPressed: ready

                        ? () {

                            ref

                                .read(registrationAuthBackendProvider.notifier)

                                .state = AuthBackend.supabase;

                            context.push(RouteNames.register);

                          }

                        : null,

                  ),

                ],

              ),

            ),

            if (crudEnabled) ...[

              const SizedBox(height: AppSpacing.lg),

              SupabaseUserPanel(authUser: user!),

              const SizedBox(height: AppSpacing.md),

              SupabaseTasksPanel(userId: user.id),

            ] else if (ready && supabaseSession) ...[

              const SizedBox(height: AppSpacing.md),

              AdaCard(

                child: Text(

                  l10n.supabaseCrudUnavailable,

                  style: Theme.of(context).textTheme.bodySmall,

                ),

              ),

            ],

            const SizedBox(height: AppSpacing.xxl),

          ],

        ),

      ),

    );

  }

}


