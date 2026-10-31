import 'package:abould_ada/core/theme/app_colors.dart';
import 'package:abould_ada/core/theme/app_radius.dart';
import 'package:flutter/material.dart';

class AdaShimmer extends StatefulWidget {
  const AdaShimmer({
    super.key,
    this.width,
    this.height = 72,
    this.borderRadius = AppRadius.md,
  });

  final double? width;
  final double height;
  final double borderRadius;

  @override
  State<AdaShimmer> createState() => _AdaShimmerState();
}

class _AdaShimmerState extends State<AdaShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  (Color base, Color highlight) _colors(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (isDark) {
      final base = Theme.of(context).colorScheme.surfaceContainerHighest;
      return (base, AppColors.neutral600.withValues(alpha: 0.35));
    }
    // Stronger contrast on light surfaces (neutral50 / white).
    return (AppColors.neutral300, AppColors.neutral0);
  }

  @override
  Widget build(BuildContext context) {
    final (base, highlight) = _colors(context);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Theme.of(context).brightness == Brightness.light
                ? Border.all(color: AppColors.neutral200)
                : null,
            gradient: LinearGradient(
              begin: Alignment(-1 + _controller.value * 2, 0),
              end: Alignment(1 + _controller.value * 2, 0),
              colors: [base, highlight, base],
            ),
          ),
        );
      },
    );
  }
}
