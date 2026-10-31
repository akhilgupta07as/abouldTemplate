import 'package:abould_ada/core/theme/app_colors.dart';
import 'package:abould_ada/core/theme/app_radius.dart';
import 'package:flutter/material.dart';

/// Soft UI modal matching app dialog style (rounded sheet, pill actions).
class AdaModalDialog extends StatelessWidget {
  const AdaModalDialog({
    super.key,
    required this.title,
    this.message,
    this.content,
    this.primaryLabel,
    this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
    this.primaryDestructive = false,
    this.showCloseButton = true,
  });

  final String title;
  final String? message;
  final Widget? content;
  final String? primaryLabel;
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final bool primaryDestructive;
  final bool showCloseButton;

  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    String? message,
    Widget? content,
    String? primaryLabel,
    VoidCallback? onPrimary,
    String? secondaryLabel,
    VoidCallback? onSecondary,
    bool primaryDestructive = false,
    bool showCloseButton = true,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: AppColors.neutral900.withValues(alpha: 0.45),
      builder: (ctx) => AdaModalDialog(
        title: title,
        message: message,
        content: content,
        primaryLabel: primaryLabel,
        onPrimary: onPrimary,
        secondaryLabel: secondaryLabel,
        onSecondary: onSecondary,
        primaryDestructive: primaryDestructive,
        showCloseButton: showCloseButton,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.neutral0;
    final titleColor =
        isDark ? AppColors.neutral100 : AppColors.dialogTextPrimary;
    final bodyColor =
        isDark ? AppColors.neutral500 : AppColors.dialogTextSecondary;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 40,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                    color: titleColor,
                    letterSpacing: -0.3,
                  ),
                ),
                if (message != null && message!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    message!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.55,
                      color: bodyColor,
                    ),
                  ),
                ],
                if (content != null) ...[
                  const SizedBox(height: 20),
                  content!,
                ],
                if (primaryLabel != null) ...[
                  const SizedBox(height: 28),
                  _AdaDialogPillButton(
                    label: primaryLabel!,
                    onPressed: onPrimary,
                    destructive: primaryDestructive,
                    filled: true,
                  ),
                ],
                if (secondaryLabel != null) ...[
                  const SizedBox(height: 12),
                  _AdaDialogPillButton(
                    label: secondaryLabel!,
                    onPressed: onSecondary,
                    filled: false,
                  ),
                ],
              ],
            ),
          ),
          if (showCloseButton)
            Positioned(
              top: -8,
              right: -8,
              child: _AdaDialogCloseButton(
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
        ],
      ),
    );
  }
}

class _AdaDialogPillButton extends StatelessWidget {
  const _AdaDialogPillButton({
    required this.label,
    required this.onPressed,
    required this.filled,
    this.destructive = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool filled;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color bg;
    Color fg;
    if (filled) {
      if (destructive) {
        bg = AppColors.dialogDestructive;
        fg = AppColors.neutral0;
      } else {
        bg = Theme.of(context).colorScheme.primary;
        fg = Theme.of(context).colorScheme.onPrimary;
      }
    } else {
      bg = isDark
          ? AppColors.darkSurfaceVariant
          : AppColors.dialogSecondaryButton;
      fg = isDark ? AppColors.neutral100 : AppColors.dialogTextPrimary;
    }

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.full),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}

class _AdaDialogCloseButton extends StatelessWidget {
  const _AdaDialogCloseButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final bg = AppColors.dialogCloseBackgroundFor(brightness);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Ink(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: bg,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.neutral900.withValues(alpha: 0.18),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.close,
            size: 20,
            color: AppColors.neutral0,
          ),
        ),
      ),
    );
  }
}
