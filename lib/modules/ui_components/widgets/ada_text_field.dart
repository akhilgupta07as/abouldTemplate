import 'package:abould_ada/modules/ui_components/widgets/inputs/ada_field_decoration.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';



class AdaTextField extends StatelessWidget {

  const AdaTextField({

    super.key,

    required this.controller,

    required this.label,

    this.hint,

    this.keyboardType,

    this.textInputAction,

    this.obscureText = false,

    this.prefixIcon,

    this.suffixIcon,

    this.validator,

    this.autofillHints,

    this.inputFormatters,

    this.maxLines = 1,

    this.onSubmitted,

    this.onChanged,

  });



  final TextEditingController controller;

  final String label;

  final String? hint;

  final TextInputType? keyboardType;

  final TextInputAction? textInputAction;

  final bool obscureText;

  final IconData? prefixIcon;

  final Widget? suffixIcon;

  final String? Function(String?)? validator;

  final Iterable<String>? autofillHints;

  final List<TextInputFormatter>? inputFormatters;

  final int maxLines;

  final ValueChanged<String>? onSubmitted;

  final ValueChanged<String>? onChanged;



  @override

  Widget build(BuildContext context) {

    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text(

          label,

          style: Theme.of(context).textTheme.labelLarge?.copyWith(

                fontWeight: FontWeight.w600,

              ),

        ),

        const SizedBox(height: 8),

        TextFormField(

          controller: controller,

          keyboardType: keyboardType,

          textInputAction: textInputAction,

          obscureText: obscureText,

          validator: validator,

          autofillHints: autofillHints,

          inputFormatters: inputFormatters,

          maxLines: maxLines,

          onFieldSubmitted: onSubmitted,

          onChanged: onChanged,

          decoration: AdaFieldDecoration.base(

            context,

            hintText: hint,

            prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 22) : null,

            suffixIcon: suffixIcon,

          ),

        ),

      ],

    );

  }

}


