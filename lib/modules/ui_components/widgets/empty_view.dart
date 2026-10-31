import 'package:abould_ada/core/localization/l10n_extensions.dart';
import 'package:abould_ada/core/theme/app_colors.dart';
import 'package:abould_ada/core/theme/app_radius.dart';
import 'package:abould_ada/core/theme/app_shadows.dart';
import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    required this.message,
    this.title,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
    this.compact = false,
  });

  final String? title;
  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;
    final displayTitle = title ?? context.l10n.emptyDefaultTitle;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(compact ? AppSpacing.md : AppSpacing.lg),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: compact ? 320 : 380),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.xl + 4),
              boxShadow: AppShadows.soft(
                isDark ? Colors.black : AppColors.primary,
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: compact ? AppSpacing.lg : AppSpacing.xl,
                vertical: compact ? AppSpacing.lg : AppSpacing.xxl,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.xl + 4),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          AppColors.darkSurface,
                          AppColors.darkSurfaceVariant.withValues(alpha: 0.6),
                        ]
                      : [
                          AppColors.neutral0,
                          AppColors.violet50.withValues(alpha: 0.85),
                        ],
                ),
                border: Border.all(
                  color: isDark
                      ? AppColors.neutral700.withValues(alpha: 0.5)
                      : AppColors.violet100.withValues(alpha: 0.8),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _EmptyIllustration(icon: icon, compact: compact),
                  SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
                  Text(
                    displayTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.4,
                          color: isDark
                              ? AppColors.neutral100
                              : AppColors.neutral800,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDark
                              ? AppColors.neutral500
                              : AppColors.neutral600,
                          height: 1.5,
                        ),
                  ),
                  if (actionLabel != null && onAction != null) ...[
                    const SizedBox(height: AppSpacing.lg),
                    FilledButton(
                      onPressed: onAction,
                      child: Text(actionLabel!),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyIllustration extends StatelessWidget {
  const _EmptyIllustration({
    required this.icon,
    required this.compact,
  });

  final IconData icon;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final outer = compact ? 88.0 : 112.0;
    final inner = compact ? 64.0 : 80.0;
    final iconSize = compact ? 32.0 : 40.0;

    return SizedBox(
      width: outer,
      height: outer,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: outer,
            height: outer,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.cyan500.withValues(alpha: 0.12),
                  AppColors.primary.withValues(alpha: 0.06),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Container(
            width: inner,
            height: inner,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.violet100,
                  AppColors.violet50,
                ],
              ),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: iconSize,
              color: AppColors.primary,
            ),
          ),
          Positioned(
            top: compact ? 6 : 8,
            right: compact ? 10 : 14,
            child: _Dot(color: AppColors.cyan500.withValues(alpha: 0.85)),
          ),
          Positioned(
            bottom: compact ? 10 : 12,
            left: compact ? 8 : 10,
            child: _Dot(
              color: AppColors.pink500.withValues(alpha: 0.7),
              size: 8,
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color, this.size = 10});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
