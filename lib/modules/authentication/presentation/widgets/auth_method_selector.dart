import 'package:abould_ada/core/config/auth_backend.dart';
import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class AuthMethodSelector extends StatelessWidget {
  const AuthMethodSelector({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelected,
    this.title = 'Sign in with',
  });

  final List<AuthBackend> options;
  final AuthBackend selected;
  final ValueChanged<AuthBackend> onSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final backend in options)
              ChoiceChip(
                label: Text(backend.displayName),
                selected: selected == backend,
                onSelected: (on) {
                  if (on) onSelected(backend);
                },
              ),
          ],
        ),
      ],
    );
  }
}
