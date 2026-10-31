import 'package:abould_ada/core/localization/app_locales.dart';
import 'package:abould_ada/core/services/locale_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdaLocaleToggle extends ConsumerWidget {
  const AdaLocaleToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeControllerProvider);
    final scheme = Theme.of(context).colorScheme;

    return SegmentedButton<Locale>(
      segments: const [
        ButtonSegment(
          value: AppLocales.english,
          label: Text('EN'),
          icon: Icon(Icons.language, size: 18),
        ),
        ButtonSegment(
          value: AppLocales.hindi,
          label: Text('HI'),
          icon: Icon(Icons.translate, size: 18),
        ),
      ],
      selected: {locale},
      onSelectionChanged: (selected) {
        ref.read(localeControllerProvider.notifier).setLocale(selected.first);
      },
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: WidgetStatePropertyAll(
          BorderSide(color: scheme.outline.withValues(alpha: 0.35)),
        ),
      ),
    );
  }
}
