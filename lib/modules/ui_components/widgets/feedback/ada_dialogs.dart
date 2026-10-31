import 'package:abould_ada/modules/ui_components/widgets/feedback/ada_modal_dialog.dart';
import 'package:flutter/material.dart';

abstract final class AdaDialogs {
  static Future<void> success(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    return AdaModalDialog.show<void>(
      context,
      title: title,
      message: message,
      primaryLabel: 'OK',
      onPrimary: () => Navigator.pop(context),
      showCloseButton: true,
    );
  }

  static Future<void> error(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    return AdaModalDialog.show<void>(
      context,
      title: title,
      message: message,
      primaryLabel: 'Close',
      onPrimary: () => Navigator.pop(context),
      primaryDestructive: false,
    );
  }

  static Future<bool> confirmSignOut(BuildContext context) {
    return confirm(
      context,
      title: 'Sign out?',
      message:
          'You will leave your current session and return to the login screen.',
      confirmLabel: 'Sign out',
      cancelLabel: 'Stay signed in',
      destructive: true,
    );
  }

  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool destructive = false,
  }) async {
    final result = await AdaModalDialog.show<bool>(
      context,
      title: title,
      message: message,
      primaryLabel: confirmLabel,
      onPrimary: () => Navigator.pop(context, true),
      secondaryLabel: cancelLabel,
      onSecondary: () => Navigator.pop(context, false),
      primaryDestructive: destructive,
    );
    return result ?? false;
  }

  /// Form dialog: primary = save, secondary = cancel. Returns `true` if saved.
  static Future<bool> editForm(
    BuildContext context, {
    required String title,
    String? message,
    required Widget form,
    String saveLabel = 'Save',
    String cancelLabel = 'Cancel',
  }) async {
    final result = await AdaModalDialog.show<bool>(
      context,
      title: title,
      message: message,
      content: form,
      primaryLabel: saveLabel,
      onPrimary: () => Navigator.pop(context, true),
      secondaryLabel: cancelLabel,
      onSecondary: () => Navigator.pop(context, false),
      primaryDestructive: false,
    );
    return result ?? false;
  }

  static Future<void> bottomSheet(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}
