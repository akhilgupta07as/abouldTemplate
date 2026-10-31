import 'package:abould_ada/core/localization/l10n_extensions.dart';
import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:abould_ada/modules/authentication/domain/auth_user.dart';
import 'package:abould_ada/modules/supabase/di/supabase_crud_providers.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupabaseUserPanel extends ConsumerWidget {
  const SupabaseUserPanel({super.key, required this.authUser});

  final AuthUser authUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(supabaseProfileStreamProvider);
    final scheme = Theme.of(context).colorScheme;

    final l10n = context.l10n;

    return AdaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person_outline_rounded, color: scheme.primary),
              const SizedBox(width: 8),
              Text(
                l10n.supabaseUserTable,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          profileAsync.when(
            loading: () => const LinearProgressIndicator(minHeight: 2),
            error: (e, _) => Text(
              'Could not load profile: $e\nRun migration 002_profiles_and_simplify_tasks.sql',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            data: (profile) {
              final email = profile?.email ?? authUser.email;
              final name = profile?.fullName.isNotEmpty == true
                  ? profile!.fullName
                  : (authUser.displayName ?? '—');
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Row(label: l10n.supabaseUserId, value: authUser.id),
                  const SizedBox(height: 8),
                  _Row(label: l10n.supabaseEmail, value: email),
                  const SizedBox(height: 8),
                  _Row(label: l10n.supabaseFullName, value: name),
                  if (profile?.createdAt != null) ...[
                    const SizedBox(height: 8),
                    _Row(
                      label: l10n.supabaseProfileCreated,
                      value: profile!.createdAt!.toLocal().toString().split('.').first,
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 108,
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }
}
