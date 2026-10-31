import 'package:abould_ada/core/theme/app_colors.dart';
import 'package:abould_ada/core/theme/app_radius.dart';
import 'package:flutter/material.dart';

/// Shared borders and fills for ADA text-style inputs (light + dark).
abstract final class AdaFieldDecoration {
  static bool _isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color enabledBorderColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _isDark(context)
        ? scheme.outline.withValues(alpha: 0.55)
        : AppColors.neutral400;
  }

  static Color fillColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _isDark(context)
        ? scheme.surfaceContainerHighest.withValues(alpha: 0.45)
        : AppColors.neutral0;
  }

  static OutlineInputBorder outline(
    BuildContext context, {
    Color? color,
    double width = 1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: BorderSide(
        color: color ?? enabledBorderColor(context),
        width: width,
      ),
    );
  }

  static InputDecoration base(
    BuildContext context, {
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: fillColor(context),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: outline(context),
      enabledBorder: outline(context),
      focusedBorder: outline(context, color: scheme.primary, width: 1.5),
      errorBorder: outline(context, color: scheme.error),
      focusedErrorBorder: outline(context, color: scheme.error, width: 1.5),
      disabledBorder: outline(
        context,
        color: _isDark(context)
            ? scheme.outline.withValues(alpha: 0.25)
            : AppColors.neutral200,
      ),
    );
  }
}
