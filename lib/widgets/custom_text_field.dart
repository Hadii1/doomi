import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/utils/styles/spacings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTextField extends ConsumerWidget {
  const CustomTextField({
    required this.onChanged,
    this.onSubmitted,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.done,
    this.hint = '',
    this.labelAboveField = '',
  });

  final String hint;
  final Function(String) onChanged;
  final Function(String)? onSubmitted;
  final String labelAboveField;
  final TextInputType inputType;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelAboveField.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
              bottom: Spacings.spacingFactor * 2,
            ),
            child: Text(
              labelAboveField,
              style: theme.labelStyle,
            ),
          ),
        TextField(
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          cursorWidth: 1,
          cursorHeight: 16,
          cursorColor: theme.textColor,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: theme.hintStyle,
            contentPadding: const EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(
                color: theme.textFieldBorderColor,
                width: 0.6,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(
                color: theme.textFieldFocusedBorderColor,
                width: 0.7,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
