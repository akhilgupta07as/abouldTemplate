import 'package:abould_ada/core/localization/l10n_extensions.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_text_field.dart';
import 'package:abould_ada/modules/ui_components/widgets/inputs/ada_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdaEmailField extends StatelessWidget {
  const AdaEmailField({
    super.key,
    required this.controller,
    this.validator,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return AdaTextField(
      controller: controller,
      label: 'Email',
      hint: 'you@company.com',
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      prefixIcon: Icons.mail_outline_rounded,
      validator: validator,
    );
  }
}

class AdaPhoneField extends StatelessWidget {
  const AdaPhoneField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AdaTextField(
      controller: controller,
      label: 'Phone',
      hint: '+91 98765 43210',
      keyboardType: TextInputType.phone,
      prefixIcon: Icons.phone_outlined,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9+\s-]'))],
    );
  }
}

class AdaSearchField extends StatelessWidget {
  const AdaSearchField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return AdaTextField(
      controller: controller,
      label: context.l10n.searchLabel,
      hint: context.l10n.searchHint,
      prefixIcon: Icons.search_rounded,
      textInputAction: TextInputAction.search,
      onChanged: onChanged,
      onSubmitted: onChanged,
    );
  }
}

class AdaMultilineField extends StatelessWidget {
  const AdaMultilineField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AdaTextField(
      controller: controller,
      label: 'Notes',
      hint: 'Multiline text…',
      maxLines: 4,
    );
  }
}

class AdaSwitchField extends StatelessWidget {
  const AdaSwitchField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      value: value,
      onChanged: onChanged,
    );
  }
}

class AdaCheckboxField extends StatelessWidget {
  const AdaCheckboxField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}

class AdaNumberField extends StatelessWidget {
  const AdaNumberField({
    super.key,
    required this.controller,
    this.label = 'Amount',
    this.hint = '0',
    this.allowDecimal = true,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final bool allowDecimal;

  @override
  Widget build(BuildContext context) {
    return AdaTextField(
      controller: controller,
      label: label,
      hint: hint,
      keyboardType: TextInputType.numberWithOptions(decimal: allowDecimal),
      prefixIcon: Icons.numbers_rounded,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(allowDecimal ? r'[0-9.]' : r'[0-9]'),
        ),
      ],
    );
  }
}

class AdaDateField extends StatelessWidget {
  const AdaDateField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.firstDate,
    this.lastDate,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: value ?? now,
      firstDate: firstDate ?? DateTime(now.year - 5),
      lastDate: lastDate ?? DateTime(now.year + 5),
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final text = value == null
        ? 'Select date'
        : MaterialLocalizations.of(context).formatMediumDate(value!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _pick(context),
          borderRadius: BorderRadius.circular(12),
          child: InputDecorator(
            decoration: AdaFieldDecoration.base(
              context,
              suffixIcon: const Icon(Icons.calendar_today_outlined),
            ),
            child: Text(text),
          ),
        ),
      ],
    );
  }
}

class AdaTimeField extends StatelessWidget {
  const AdaTimeField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final TimeOfDay? value;
  final ValueChanged<TimeOfDay> onChanged;

  Future<void> _pick(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: value ?? TimeOfDay.now(),
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final text = value == null ? 'Select time' : value!.format(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _pick(context),
          borderRadius: BorderRadius.circular(12),
          child: InputDecorator(
            decoration: AdaFieldDecoration.base(
              context,
              suffixIcon: const Icon(Icons.schedule_outlined),
            ),
            child: Text(text),
          ),
        ),
      ],
    );
  }
}

class AdaRadioOption<T> {
  const AdaRadioOption({required this.value, required this.label});

  final T value;
  final String label;
}

class AdaRadioGroupField<T> extends StatelessWidget {
  const AdaRadioGroupField({
    super.key,
    required this.label,
    required this.options,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final List<AdaRadioOption<T>> options;
  final T? value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        ...options.map(
          (o) => RadioListTile<T>(
            contentPadding: EdgeInsets.zero,
            title: Text(o.label),
            value: o.value,
            groupValue: value,
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
          ),
        ),
      ],
    );
  }
}

class AdaSearchableDropdownOption<T> {
  const AdaSearchableDropdownOption({required this.value, required this.label});

  final T value;
  final String label;
}

class AdaSearchableDropdownField<T> extends StatelessWidget {
  const AdaSearchableDropdownField({
    super.key,
    required this.label,
    required this.options,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final List<AdaSearchableDropdownOption<T>> options;
  final T? value;
  final ValueChanged<T?> onChanged;

  Future<void> _open(BuildContext context) async {
    final selected = await showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) {
        final query = ValueNotifier('');
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(ctx).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search…',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (v) => query.value = v,
                ),
              ),
              ValueListenableBuilder<String>(
                valueListenable: query,
                builder: (context, q, _) {
                  final filtered = options
                      .where(
                        (o) =>
                            o.label.toLowerCase().contains(q.toLowerCase()),
                      )
                      .toList();
                  return SizedBox(
                    height: 280,
                    child: ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final opt = filtered[index];
                        return ListTile(
                          title: Text(opt.label),
                          selected: opt.value == value,
                          onTap: () => Navigator.pop(ctx, opt.value),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
    if (selected != null) onChanged(selected);
  }

  @override
  Widget build(BuildContext context) {
    String? display;
    for (final o in options) {
      if (o.value == value) {
        display = o.label;
        break;
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _open(context),
          borderRadius: BorderRadius.circular(12),
          child: InputDecorator(
            decoration: AdaFieldDecoration.base(
              context,
              suffixIcon: const Icon(Icons.arrow_drop_down),
            ),
            child: Text(display ?? 'Choose option'),
          ),
        ),
      ],
    );
  }
}

class AdaDropdownField<T> extends StatelessWidget {
  const AdaDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          initialValue: value,
          items: items,
          onChanged: onChanged,
          decoration: AdaFieldDecoration.base(context).copyWith(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}
