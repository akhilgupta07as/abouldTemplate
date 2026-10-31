import 'package:abould_ada/core/theme/app_radius.dart';
import 'package:abould_ada/core/theme/app_shadows.dart';
import 'package:flutter/material.dart';

class AdaCard extends StatelessWidget {
  const AdaCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.gradient,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;

    final content = Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        gradient: gradient,
        color: gradient == null ? surface : null,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: gradient == null ? AppShadows.card(context) : null,
        border: gradient != null
            ? null
            : Border.all(
                color: Theme.of(context).colorScheme.outline.withValues(
                      alpha: 0.12,
                    ),
              ),
      ),
      child: child,
    );

    if (onTap == null) return content;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: content,
      ),
    );
  }
}
