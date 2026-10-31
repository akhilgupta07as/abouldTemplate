import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:abould_ada/features/dashboard/providers/workspace_config_provider.dart';
import 'package:abould_ada/modules/firebase/di/firebase_providers.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardFirebasePanel extends ConsumerWidget {
  const DashboardFirebasePanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(ensureWorkspaceConfigProvider);
    final workspace = ref.watch(workspaceConfigProvider);
    final fcm = ref.watch(fcmTokenProvider);
    final scheme = Theme.of(context).colorScheme;

    final welcome = workspace.when(
      data: (data) =>
          data?['welcomeMessage']?.toString() ?? 'Firestore connected.',
      loading: () => 'Loading workspace config…',
      error: (e, _) {
        final msg = e.toString();
        if (msg.contains('permission-denied')) {
          return 'Firestore: sign in with Firebase (not API) and publish rules '
              'for users/{uid}/** and todo collection.';
        }
        return 'Firestore: check rules / network ($e)';
      },
    );

    final tokenPreview = fcm.when(
      data: (t) {
        if (t == null) return 'FCM token pending';
        if (t.length <= 20) return t;
        return '${t.substring(0, 20)}…';
      },
      loading: () => 'Fetching FCM token…',
      error: (error, stackTrace) => 'FCM unavailable',
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: AdaCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.local_fire_department_rounded,
                    color: scheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Firebase services',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              welcome,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.4,
                  ),
            ),
            const SizedBox(height: AppSpacing.md),
            _RowLabel(label: 'Cloud Messaging', value: tokenPreview),
            const SizedBox(height: 6),
            const _RowLabel(
              label: 'Modules active',
              value: 'Auth, Firestore, Storage, FCM, Analytics, Crashlytics',
            ),
          ],
        ),
      ),
    );
  }
}

class _RowLabel extends StatelessWidget {
  const _RowLabel({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}
