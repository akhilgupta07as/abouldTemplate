import 'package:abould_ada/core/localization/l10n_extensions.dart';
import 'package:abould_ada/core/services/app_lifecycle_service.dart';
import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileLifecyclePanel extends ConsumerWidget {
  const ProfileLifecyclePanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appLifecycleProvider);
    return AdaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.appLifecycleTitle,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text('${context.l10n.lifecycleState}: ${state.name}'),
        ],
      ),
    );
  }
}
