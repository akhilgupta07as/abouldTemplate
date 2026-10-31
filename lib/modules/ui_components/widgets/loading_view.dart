import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:abould_ada/modules/ui_components/widgets/feedback/ada_shimmer.dart';
import 'package:flutter/material.dart';

/// Full-screen or embedded loading placeholder using shimmer (no spinner).
class LoadingView extends StatelessWidget {
  const LoadingView({
    super.key,
    this.message,
    this.itemCount = 4,
  });

  final String? message;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < itemCount; i++) ...[
              const AdaShimmer(height: 56),
              if (i < itemCount - 1) const SizedBox(height: AppSpacing.md),
            ],
            if (message != null) ...[
              const SizedBox(height: AppSpacing.lg),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
