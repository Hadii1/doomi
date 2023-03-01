// ignore_for_file: library_private_types_in_public_api

import 'package:doomi/providers/locale_provider.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/services/navigation_service.dart';
import 'package:doomi/utils/extensions.dart';
import 'package:doomi/utils/styles/spacings.dart';
import 'package:doomi/widgets/cta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DatePicker extends ConsumerStatefulWidget {
  final DateTime? initialDate;
  final String hint;
  final String textAboveTextField;
  final Function(DateTime) onDateChanged;

  const DatePicker({
    super.key,
    this.initialDate,
    this.textAboveTextField = '',
    required this.onDateChanged,
    this.hint = '',
  });

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends ConsumerState<DatePicker> {
  late TextEditingController _controller;
  late DateTime _selectedDate;
  late DateTime _tempDate;

  @override
  void initState() {
    super.initState();

    _selectedDate = widget.initialDate ?? DateTime.now();
    _tempDate = _selectedDate;
    _controller = TextEditingController(
      text: _selectedDate.getReadableDate(ref.read(localProvider)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (BuildContext builder) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Spacings.spacingFactor,
                    horizontal: Spacings.spacingFactor * 2,
                  ),
                  child: CtaButton(
                    label: 'Verify',
                    padding: const EdgeInsets.symmetric(
                      vertical: Spacings.spacingFactor,
                      horizontal: Spacings.spacingFactor * 3,
                    ),
                    textSize: 18,
                    onPressed: () {
                      _selectedDate = _tempDate;
                      setState(() {});
                      widget.onDateChanged(_selectedDate);
                      _controller.text = _selectedDate
                          .getReadableDate(ref.watch(localProvider));
                      NavigatorService.pop(context);
                    },
                  ),
                ),
                Container(
                  color: theme.background,
                  height: MediaQuery.of(context).copyWith().size.height / 3,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: _selectedDate,
                    onDateTimeChanged: (DateTime date) {
                      _tempDate = date;
                      setState(() {});
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.textAboveTextField.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(
                bottom: Spacings.spacingFactor,
              ),
              child: Text(
                widget.textAboveTextField,
                style: theme.labelStyle,
              ),
            ),
          AbsorbPointer(
            child: TextField(
              controller: _controller,
              style: theme.body3,
              decoration: InputDecoration(
                hintText: widget.hint.isEmpty
                    ? DateTime.now().getReadableDate(ref.read(localProvider))
                    : widget.hint,
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
          ),
        ],
      ),
    );
  }
}
