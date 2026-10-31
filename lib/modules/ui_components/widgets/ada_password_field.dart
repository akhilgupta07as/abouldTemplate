import 'package:abould_ada/modules/ui_components/widgets/ada_text_field.dart';
import 'package:flutter/material.dart';

class AdaPasswordField extends StatefulWidget {
  const AdaPasswordField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.validator,
    this.textInputAction,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  @override
  State<AdaPasswordField> createState() => _AdaPasswordFieldState();
}

class _AdaPasswordFieldState extends State<AdaPasswordField> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return AdaTextField(
      controller: widget.controller,
      label: widget.label,
      hint: widget.hint,
      obscureText: !_visible,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: widget.textInputAction,
      autofillHints: const [AutofillHints.password],
      validator: widget.validator,
      onSubmitted: widget.onSubmitted,
      prefixIcon: Icons.lock_outline_rounded,
      suffixIcon: IconButton(
        onPressed: () => setState(() => _visible = !_visible),
        icon: Icon(
          _visible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        ),
      ),
    );
  }
}
