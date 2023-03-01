import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/utils/styles/spacings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTextField extends ConsumerStatefulWidget {
  const CustomTextField({
    Key? key,
    this.hint = '',
    this.initialText = '',
    required this.onChanged,
    this.onSubmitted,
    this.labelAboveField = '',
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.done,
  }) : super(key: key);

  final String hint;
  final String initialText;
  final Function(String) onChanged;
  final Function(String)? onSubmitted;
  final String labelAboveField;
  final TextInputType inputType;
  final TextInputAction inputAction;

  @override
  ConsumerState<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends ConsumerState<CustomTextField> {
  late final TextEditingController textController;

  @override
  void initState() {
    textController = TextEditingController(text: widget.initialText);
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelAboveField.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
              bottom: Spacings.spacingFactor * 2,
            ),
            child: Text(
              widget.labelAboveField,
              style: theme.labelStyle,
            ),
          ),
        TextField(
          controller: textController,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          cursorWidth: 1,
          cursorHeight: 16,
          cursorColor: theme.textColor,
          style: theme.body3,
          decoration: InputDecoration(
            hintText: widget.hint,
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
